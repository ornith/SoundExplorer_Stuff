UNIT KMeans1F;

INTERFACE

uses forms,classes,controls,sysutils,rfjchart,math,windows;

type waveformf=record
	timestamp: double;
	wavformf: array[0..20] of double;
	end;

type templrecrd=record
	timestamp:real;
	templatenum:integer;
	positivity: integer;
	negativity: integer;
	end;

type
      Tdouble= array[0..20] of double;
      Pdouble= ^Tdouble;

const maxspikes=100000;//max number of records in the waverecord-array
const maxiterations = 2000; 	//to prevent the algorithm from running forever

var
   //OUTPUT
   clustersobtained: integer;   	//clusters obtained so far (= numclusters when done clustering)
   iteration: integer;			//iterations done so far. Initialisation is iteration 1
   thedistances:array[0..maxiterations] of double;//long double; list of total distances at each iteration

   //SInt16; list of cluster assignments to ge with the waveforms
   iwork:array of smallint;
   iscore:array of int64;
   //piwork:array of smallint;

   //summaries of each cluster. 64 datapoints,21 clusters+1garbage
   sum:array of array of array of double;
   old_sum:array of array of array of double;
   //psum:array of array of array of double;

   data1,data2:array[0..20] of double;

   //INPUT  THESE VARIABLES ARE SET BY THE USER AND ARE INPUT OF THIS UNIT
   numclusters: integer;		//clusters wanted by user (k of k-means)
   maxlines: integer;			//number of waveform records
   firstdatpt: integer;		        //first datapoint in the waveform used for the clustering (1..156)
   lastdatpt:integer;			//last datapoint in the waveform used for the clustering (1..256; lastdatpt > firstdatpt!!!)
   ClusterMethodFlag:boolean;	        //if true:faster clustering, if false: slower clustering SET THIS!!!
   RemoveOrphans:boolean;		//if true, orphans are removed, if false not
   minclustsize:integer;		//belongs to deorphanize. Is the minimum we still accept as a cluster

   //
   Pform:Tform;
   graph:Trfjchart;
   Graphupdate:boolean;

   //
   //Avec1:TSSEVector;
   //Avec2:TFvector;


   //routines called from outside the unit
   procedure InitKMeans();
   procedure DoKMeans();

   //routines called within the unit
   procedure SplitCluster( mxvarcl:integer ; var nwcl:integer );
   procedure ShuffleRecords();

   //procedure UpdateResults();
   function FetchItemAt(xindex:integer; var myWaveformf: waveformf):boolean;
   procedure DeOrphanize();
   procedure UpdateDistances();

   //show data
   procedure showspike(window,wave:integer);
   procedure showcluster(window,cluster:integer);
   procedure showclusteravg(window,cluster:integer);
   procedure showwvfrm(window:integer;wvfrm:waveformf);

   //move item
   procedure MoveItem(FromCluster,ToCluster:integer;Item:integer);

   //result:=SqrDistance(@Data1[0],@Data2[0],n);
   function SqrDistance(Data1, Data2: pDouble; n: Integer): Extended;
   function LinDistance(Data1, Data2: pDouble; n: Integer): Extended;
   function SQRDistanceF(Data1, Data2: pDouble; n: Integer): Extended;
   procedure DistributeGarbage;

implementation

uses wav_count,unit32;

var

   //number of datapoints used of the 256 in the waveform.wavform array
   numdatpts : integer;
   shuffled : boolean;
   i:integer;

function LinDistance(Data1, Data2: pDouble; n: Integer): Extended;
var i,j:integer;
    dist:extended;
begin
   dist:=0;
   for j:=0 to n-1 do
   begin
       dist:=dist+abs(data1[j]-data2[j]);
   end;
   result:=dist;
end;

function SQRDistanceF(Data1, Data2: pDouble; n: Integer): Extended;
var i,j:integer;
    dist:extended;
begin
   dist:=0;
   for j:=0 to n-1 do
   begin
       dist:=dist+SQR(data1[j]-data2[j]);
   end;
   result:=dist;
end;

function SqrDistance(Data1, Data2: pDouble; n: Integer): Extended;

   // old code
   //
   // var i: Integer;
   //
   // begin
   // result:=0.0;
   // for i:=0 to n-1 do
   //    result:=result+Sqr(Data1^[i]-Data2^[i]);
   // end;

   // EAX: Ptr to Data1
   // EDX: Ptr to Data2
   // ECX: n

   asm
   FLDZ

   DEC ECX

   PUSH EBX
   MOV EBX, ECX
   AND EBX, 3

   AND ECX, not 3
   SHL ECX, 3

   JMP @JumpVect.Pointer[EBX*4]

@JumpVect:
   DD @@1
   DD @@2
   DD @@3
   DD @@4

@@3:
   FLD qword ptr [EAX+ECX+16]
   FSUB qword ptr [EDX+ECX+16]
   FMUL ST, ST
   FADDP
@@2:
   FLD qword ptr [EAX+ECX+8]
   FSUB qword ptr [EDX+ECX+8]
   FMUL ST, ST
   FADDP
@@1:
   FLD qword ptr [EAX+ECX]
   FSUB qword ptr [EDX+ECX]
   SUB ECX, 32
   FMUL ST, ST
   FADDP

   JS @@Done

@@4:
   FLD qword ptr [EAX+ECX]
   FSUB qword ptr [EDX+ECX]
   FMUL ST, ST
   FLD qword ptr [EAX+ECX+8]
   FSUB qword ptr [EDX+ECX+8]
   FMUL ST, ST
   FLD qword ptr [EAX+ECX+16]
   FSUB qword ptr [EDX+ECX+16]
   FMUL ST, ST
   FLD qword ptr [EAX+ECX+24]
   FSUB qword ptr [EDX+ECX+24]
   SUB ECX, 32
   FMUL ST, ST
   FADDP ST(4), ST
   FADDP ST(3), ST
   FADDP ST(2), ST
   FADDP ST(1), ST

   JNS @@4

@@Done:
   POP EBX
   FWAIT
end;


function FetchItemAt(xindex:integer; var myWaveformf: waveformf):boolean;
begin
{
        if (xindex>=low(form1.dumdata)) and (xindex<=high(form1.dumdata)) then
         begin
           mywaveform:=form1.dumdata[xindex];
         end
        else
         begin
             pform.caption:=inttostr(xindex);
         end;
}
         mywaveformf:=form1.dumdataf[xindex];

         //debug only!!!
         //mywaveformf.wavformf[0]:=mywaveformf.wavformf[9];


         //experimental elimination of parameters
         if form32.checkbox1.checked=false then mywaveformf.wavformf[0]:=0;
         if form32.checkbox2.checked=false then mywaveformf.wavformf[1]:=0;
         if form32.checkbox3.checked=false then mywaveformf.wavformf[2]:=0;
         if form32.checkbox4.checked=false then mywaveformf.wavformf[3]:=0;
         if form32.checkbox5.checked=false then mywaveformf.wavformf[4]:=0;
         if form32.checkbox6.checked=false then mywaveformf.wavformf[5]:=0;
         if form32.checkbox7.checked=false then mywaveformf.wavformf[6]:=0;
         if form32.checkbox8.checked=false then mywaveformf.wavformf[7]:=0;
         if form32.checkbox9.checked=false then mywaveformf.wavformf[8]:=0;
         if form32.checkbox10.checked=false then mywaveformf.wavformf[9]:=0;
         if form32.checkbox11.checked=false then mywaveformf.wavformf[10]:=0;
         if form32.checkbox12.checked=false then mywaveformf.wavformf[11]:=0;
 end;


procedure InitKMeans();
var
	i,dda,cl,sp: integer;//counters for cluster,datapoint,cluster,spike(line)
	ave,xmin,xmax,sd,ssq: double;
        count:INT64;
	eudist, pct: double;
	wvfrm : waveformf;
	aok : boolean;
        xxmin,xxmax:double;
begin
	iteration := 0;
	numdatpts := lastdatpt-firstdatpt +1;//if negative, something is wrong with the input
	clustersobtained := 0;//no clusters yet, after initkmeans, there is 1(one)cluster

        for i:=0 to high(iwork) do
        begin
	       	iwork[i]:=0;
         	iscore[i]:=0;
      	end;

        //fills sum-array with zeroes
      	for i := 0 to 6 do
        begin
      	   for cl := 0 to numclusters+1 do
           begin
	             for dda := 0 to numdatpts-1 do
               begin
                  sum[i,dda,cl]:=0.0;
               end;
           end;
       	end;

        xxmax:=0;
        xxmin:=maxint;
        for dda:=0 to numdatpts-1 do
        begin
      	  ave:=sum[2,dda,0];
          xmin:=sum[4,dda,0];
          xmax:=sum[5,dda,0];
          count:=trunc(sum[1,dda,0]);
          sp:=1;
          begin
	           	//CSongClusterApp::theWaves->FetchItemAt(sp,&wvfrm);
  	        	aok := FetchItemAt(sp, wvfrm);
      	  	  iwork[sp]:=0;
  	        	iscore[sp]:=0;
              ave := 0.0;
              sd := 0.0;
              xmin := maxint;
              xmax := 0.0;
              ssq := 0.0;

      	    	INC(count);
          		ave:=ave + (wvfrm.wavformf[dda+firstdatpt]-ave)/count;

                {
		if (xmin > wvfrm.wavform[dda+firstdatpt]) then
		begin
        		xmin:=wvfrm.wavform[dda+firstdatpt];
		end;

		if (xmax < wvfrm.wavform[dda+firstdatpt]) then
		begin
			xmax:=wvfrm.wavform[dda+firstdatpt];
		end;
                }
	  end;
          for sp:=1 to maxlines do
          begin
	  	//CSongClusterApp::theWaves->FetchItemAt(sp,&wvfrm);
	  	aok := FetchItemAt(sp, wvfrm);
	  	iwork[sp]:=0;
	  	iscore[sp]:=0;
        	inc(count);
		ave:=ave + (wvfrm.wavformf[dda+firstdatpt]-ave)/count;
        	ssq:=ssq+sqr(wvfrm.wavformf[dda+firstdatpt]-ave);//revised

                {
		if (xmin > wvfrm.wavform[dda+firstdatpt]) then
		begin
        		xmin:=wvfrm.wavform[dda+firstdatpt];
		end;

		if (xmax < wvfrm.wavform[dda+firstdatpt]) then
		begin
			xmax:=wvfrm.wavform[dda+firstdatpt];
		end;
                }
	  end;
  	  sd:=ssq/count ;
          sum[1,dda,0]:=count;
          sum[2,dda,0]:=ave;
          sum[3,dda,0]:=sd;
          sum[4,dda,0]:=xmin;
          sum[5,dda,0]:=xmax;
          sum[6,dda,0]:=ssq;
          if xmax>xxmax then xxmax:=xmax;
          if xmin<xxmin then xxmin:=xmin;
	end;

	//since this is the very first run, the data are the summary for the whole population.
	//therefore we will transport them to the appropriate slot (last cluster #5 as it were)

	for dda:=0 to numdatpts-1 do
        begin
          sum[1,dda,numclusters+1]:=sum[1,dda,0];
          sum[2,dda,numclusters+1]:=sum[2,dda,0];
          sum[3,dda,numclusters+1]:=sum[3,dda,0];
          sum[4,dda,numclusters+1]:=sum[4,dda,0];
          sum[5,dda,numclusters+1]:=sum[5,dda,0];
          sum[6,dda,numclusters+1]:=sum[6,dda,0];
	end;

	//add the euclidian distances of all the records to produce e. store in work
        //only needed if we keep track of eudist
        {
	eudist:=0;
	for sp:=1 to maxlines do
        begin
		//CSongClusterApp::theWaves->FetchItemAt(sp,&wvfrm);
	        aok := FetchItemAt(sp, wvfrm);
		for dda:=0 to numdatpts-1 do
		begin
                   eudist:=eudist+sqr(wvfrm.wavform[dda+firstdatpt]-sum[2,dda,0]);
                   //eudist:=eudist+abs(wvfrm.wavform[dda+firstdatpt]-sum[2,dda,0]);
		end;
	end;
        }
        //theDistances->AddItem(&eudist,sizeof(long double));{must be different}
       	//the distances may be displayed to show how well the clustering is going
        theDistances[1]:=eudist; //this represents the maximum sum of distances.
        clustersObtained:=clustersObtained+1;
        iteration:=iteration + 1;
        //the data is now read, a summary is made and the sum-array is now clean

        {
        pform.caption:='';
        graph.traces:=numclusters+1;
        graph.cols:=2;
        graph.Cols:=1+trunc(sqrt(graph.traces));
        for i:=1 to graph.traces do
        begin
            graph.trace[i].ymarginleft:=0;
            graph.trace[i].ymarginright:=0;
            graph.trace[i].xmargintop:=0;
            graph.trace[i].xmarginbottom:=0;
            graph.trace[i].drawxtop:=false;
            graph.trace[i].drawxbottom:=false;
            graph.trace[i].drawyleft:=false;
            graph.trace[i].drawyright:=false;
            graph.trace[i].yaxislegend:='';
            graph.trace[i].ygmin:=0;
            graph.trace[i].ygmax:=xxmax*1.1;
        end;
        graph.setuptraces;
        graph.drawaxes;
        graph.clear;
        }

end;

procedure DoKMeans();//may only be called if InitKmeans has been done!!!!!!!!!
var
	maxsd, sd: double;//Float64
	maxvarcl, count1, ccl,dda, newcl: integer;//SInt32
        i:integer;
        t1,t2:int64;
	label 100;
begin
        queryperformancecounter(t1);
	iteration:= iteration + 1;
        //
        {
        if graphupdate then
        begin
          graph.clear;
          graph.drawframes;
          for i:=0 to numclusters-1 do
          begin
             showcluster(1+i+numclusters,i);
          end;
          graph.update;
          application.ProcessMessages;
        end;
        }
        //

	//find cluster with largest variance
  //cluster with largest variance is maxvarcl.
	maxsd:=0.0;
	maxvarcl:=-1;
	for ccl:=0 to numclusters-1 do
	begin
		sd:=0.0;
		for dda:=0 to numdatpts-1 do
    begin
			sd:=sd+sum[3,dda,ccl];
		end;
		if (sd>maxsd) then
		begin
			maxsd:=sd;
			maxvarcl:=ccl;
		end;
	end;

	//find cluster with n:=0 to promote to new cluster; newcl:=curclust+1;
	newcl:=0;
	for ccl:=0 to numclusters-1 do
	begin
		count1:=round(sum[1,1,ccl]);
		if (count1=0) then
		begin
			newcl:=ccl;
      goto 100;
		end;
	end;

100://continue here when the 0 cluster has been found (it may be anywhere, watch out)

  //SplitCluster
	SplitCluster(maxvarcl, newcl);
	if(ClusterMethodFlag)then
	  begin//if ClusterMethodFlag is set to do the faster clustering (is checked), do not keep shuffling
	   	ShuffleRecords();
    end
	else
	  begin//else go whole hog
	    shuffled:=true;
   		while (shuffled=true) do
	  	begin
		  	ShuffleRecords();
  		end;
    end;

	//RemoveOrphans (if (RemoveOrphans))
	if (RemoveOrphans) then
	begin
		DeOrphanize();
    //if shuffled then Slowstats;
		//UpdateResults();
	end;

	//update distances muste be done again because deorphanizing affects the results
	UpdateDistances();
	//ShowStats
	//ShowStats();

	//MakeNewTRecord for export
	//MakeTemplRecord();(do this only when we are finished)

        //
        {
        if graphupdate then
        begin
          graph.clear;
          for i:=0 to numclusters do
          begin
            graph.trace[1+i].showtitle:=true;
            graph.trace[1+i].titleyoffset:=20;
            graph.trace[1+i].graphTitle:=inttostr(trunc(sum[1,1,i]));
          end;
          graph.drawaxes;
          graph.drawframes;
          for i:=0 to numclusters do
          begin
              showcluster(1+i,i);
          end;
          graph.update;
          application.ProcessMessages;
        end;
        }
        //
  queryperformancecounter(t2);
  form1.tsum[1]:=form1.tsum[1]+(t2-T1);
end;

procedure SplitCluster(mxvarcl: integer; var nwcl: integer);
var
	wvfrm: waveformf;
	ave,count,sd,ssq,xmin,xmax: double;
	eudist,maxdist: extended; //long double
	i,sp, dda, cmax: integer;
	aok: boolean;
  divs:double;
  t1,t2:int64;
begin
  queryperformancecounter(t1);
	cmax:=0;
	maxdist:=0.0;
	for sp:=1 to maxlines do
	begin
		if (iwork[sp]=mxvarcl) then
		begin
			aok := FetchItemAt(sp, wvfrm);
      for dda:=0 to numdatpts-1 do
    	begin
            data1[dda]:=wvfrm.wavformf[dda+firstdatpt];
            data2[dda]:=sum[2,dda,mxvarcl];
    	end;
      eudist:=SqrDistanceF(@data1[0],@data2[0],numdatpts);
     //eudist:=LinDistance(@data1[0],@data2[0],numdatpts-1);

			if (eudist > maxdist) then
			begin
				maxdist:=eudist;
				cmax:=sp;
        iscore[sp]:=round(eudist);
			end;
		end;
	end;
	iwork[cmax]:=nwcl;

	//clustersObtained+=1;
	//record #cmax has the largest distance. adjust old cluster
	aok:=FetchItemAt(cmax,wvfrm);
	for dda:=0 to numdatpts-1 do
	begin
		count:=sum[1,dda,mxvarcl];
		ave:=sum[2,dda,mxvarcl];
		ssq:=sum[6,dda,mxvarcl];
		xmin:=sum[4,dda,mxvarcl];
		xmax:=sum[5,dda,mxvarcl];
		count:=count-1;

		if (count>0) then
     begin
       divs:=1/count;
       ave:=ave-(wvfrm.wavformf[dda+firstdatpt]-ave)*divs;
     end
    else
      ave:=0;

		sum[2,dda,mxvarcl]:=ave;

		ssq:=ssq-sqr(wvfrm.wavformf[dda+firstdatpt]-ave);
		sum[6,dda,mxvarcl]:=ssq;

		if(count>1) then
     begin
       divs:=1/count;
       sd:=ssq*divs;
     end
    else
       sd:=0;

		sum[3,dda,mxvarcl]:=sd;
		sum[1,dda,mxvarcl]:=count;

		//now find new minx and maxx. will be implemented soon. This depends on the actual value that we remove here.
	end;

	//make the seed data into the next cluster basics
	for dda:=0 to numdatpts-1 do
	begin
		sum[1,dda,nwcl]:=1;
		sum[2,dda,nwcl]:=wvfrm.wavformf[dda+firstdatpt];
		sum[3,dda,nwcl]:=0;
		sum[4,dda,nwcl]:=wvfrm.wavformf[dda+firstdatpt];
		sum[5,dda,nwcl]:=wvfrm.wavformf[dda+firstdatpt];
		sum[6,dda,nwcl]:=0;
	end;

        //showclusteravg(1+nwcl+numclusters,nwcl);
        //graph.update;

   queryperformancecounter(t2);
   form1.Tsum[2]:=form1.Tsum[2]+(T2-T1)
end;

procedure showwvfrm(window:integer;wvfrm:waveformf);
var i:integer;
begin
        graph.addstart(window,1,wvfrm.wavformf[1]);
        for i:=1 to numdatpts do
        begin
           graph.addpoint(window,i,wvfrm.wavformf[i]);
        end;
end;

procedure showspike(window,wave:integer);
var wvfrm:waveformf;
begin
        FetchItemAt(wave, wvfrm);
        showwvfrm(window,wvfrm);
end;

procedure showcluster(window,cluster:integer);
var i,k:integer;
    wvfrm:waveformf;
begin
   for k:=1 to maxlines do
   begin
    if iwork[k]=cluster then
     begin
        FetchItemAt(k, wvfrm);
        showwvfrm(window,wvfrm);
     end;
   end;
end;

procedure showclusteravg(window,cluster:integer);
var i:integer;
    wvfrm:waveformf;
begin
        graph.addstart(window,1,sum[2,1,cluster]);
        for i:=1 to numdatpts do
        begin
           graph.addpoint(window,i,sum[2,i,cluster]);
        end;
end;


procedure ShuffleRecords();
var
	oldclust,sp,dda,ccl,jmin,count1:integer;
	wvfrm: waveformf;
	eudist, mindist: extended;//long double
	changed, aok: boolean;//, done=false;
        T1,T2:int64;
begin
  queryperformancecounter(t1);

	changed:=true;
	shuffled:=false;//shuffled is a global
	jmin:=-1;
	count1:=0;
	while (changed=true) do//here, a maximum should be set to the iterations, but for now we manage without
	begin
     changed:=false;
	   for sp := maxlines downto 0 do
	   begin
	   	mindist:=10000000000000000000000.0;
	   	aok := FetchItemAt(sp, wvfrm);
	   	oldclust := iwork[sp];
	    if (oldclust <> numclusters) then //if the spike is not in the garbage
       begin
        for ccl:=0 to numclusters-1 do
        begin
         if (sum[1,1,ccl]>0) then
         begin
           //move(wvfrm.wavform[0],data1[0],numdatpts*sizeof(smallint));
         	for dda:=0 to numdatpts-1 do
        	begin
            data1[dda]:=wvfrm.wavformf[dda+firstdatpt];
            data2[dda]:=sum[2,dda,ccl];
      		end;
          eudist:=SqrDistanceF(@data1[0],@data2[0],numdatpts);
          //eudist:=LinDistance(@data1[0],@data2[0],numdatpts-1);
     			if (eudist < mindist) then
		    	begin
             mindist:=eudist;
             jmin:=ccl;
             iscore[sp]:=round(eudist);
    			end;
         end;
		    end;
        //best cluster is found with this case
        //(it is cluster # jmin  with distance mindist)
        //now update the stats for the new and the old cluster
        if (jmin<>oldclust) and (jmin>=0) then //do the adjustments only when the jmin cluster is different from the current cluster
        begin
             changed:=true;
             shuffled:=true;
             iwork[sp]:=jmin;
             MoveItem(OldClust,Jmin,sp);
                        {
                        graph.clear(1+jmin);
                        showspike(1+jmin,sp);
                        graph.update;
                        application.ProcessMessages;
                        }
        end;
		   end;
        //else
    		// begin
    		// 	count1:=count1+1;
    		// end;
	   end;
     //end of one run through the records.
	end;
  queryperformancecounter(t2);
  form1.Tsum[3]:=form1.Tsum[3]+(T2-T1)
end;

//find orphan clusters containing only a few spikes specified by minspikes
//the occurrences of this cluster are removed from the waveform records
// they should be lumped together into the highest cluster number + 1

procedure DeOrphanize();
var
	count1,count2,sp,ccl,dda: integer; //SInt32 ;counts the number of orphans
        DoOrphan:boolean;
        i:integer;
begin
     //quick test: ARE there any clusters with a size <=minclustsize) ?
     DoOrphan:=false;
     for i:=0 to numclusters-1 do
     begin
         if (sum[1,1,i]<=minclustsize) then
         begin
          DoOrphan:=true;
          //exit;
         end;
     end;
     if DoOrphan then
     begin
	count1:=0;
	count2:=0;
	for sp:=1 to maxlines do
	begin
        	count1:=iwork[sp];
                //if there are only a few spikes
		if (sum[1,1,count1]<=minclustsize) then
		begin
      //it gets the cluster number of the garbage
			iwork[sp]:=numclusters;
			inc(count2);
      sum[1,1,numclusters]:=sum[1,1,numclusters]+1;
		end;
	end;

  //empty the summaries for the removed clusters including garbage
	for ccl:=0 to numclusters-1 do
	begin
		if (sum[1,1,ccl]<=minclustsize)then
		begin
			for dda:=0 to numdatpts-1 do
			begin
				sum[1,dda,ccl]:=0;
				sum[2,dda,ccl]:=0;
				sum[3,dda,ccl]:=0;
				sum[4,dda,ccl]:=0;
				sum[5,dda,ccl]:=0;
				sum[6,dda,ccl]:=0;
			end;
		end;
	end;
 end;
end;

procedure UpdateDistances();
var
	ccl,dda,sp:integer;//SInt32
	eudist: double;//long double
	wvfrm:waveformf ;
	aok:boolean;
  temp:double;
  divs:double;
  t1,t2:int64;
begin
  queryperformancecounter(t1);
  for ccl := 0 to numclusters+1 do
  begin
     for dda := 0 to numdatpts-1 do
     begin
        sum[6,dda,ccl]:=0.0;
     end;
  end;
	for ccl := 0 to numclusters do
	begin
     for sp:=0 to maxlines do
	   begin
	      if (iwork[sp]=ccl)then
	      begin
	      	aok := FetchItemAt(sp, wvfrm);
	      	for dda:=0 to numdatpts-1 do
	      	begin
                   //output is another vector here -> need Tssevecto, not sqrdist.
                   //Avec1[dda]:=wvfrm.wavform[dda+firstdatpt];
                   //Avec2[dda]:=sum[6,dda,ccl];
                   sum[6,dda,ccl]:=sum[6,dda,ccl]+sqr(wvfrm.wavformf[dda+firstdatpt]-sum[2,dda,ccl]);
	      	end;
            //Avec1.Sub(avec2);
          	//for dda:=0 to numdatpts-1 do
  	      	//begin
           //   sum[6,dda,ccl]:=avec1[dda];
	        	//end;
        end;
     end;
	   for dda:=0 to numdatpts-1 do
	   begin
       if(sum[1,dda,ccl]>1)then
       begin
          divs:=1/(sum[1,dda,ccl]);
	       	sum[3,dda,ccl]:=(sum[6,dda,ccl])*divs;
       end;
     end;
	end;

  //calculate the total error = sum of all distances to the cluster means (eudist)includes garbage
	eudist:=0;
	for ccl:=0 to numclusters do
	begin
          for dda:=0 to numdatpts-1 do
          begin
            eudist:=eudist+sum[6,dda,ccl];
          end;
	end;
	//theDistances->AddItem(&eudist,sizeof(long double));!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	theDistances[iteration]:=eudist;

  queryperformancecounter(t2);
  form1.Tsum[4]:=form1.Tsum[4]+(T2-T1)

end;


procedure MoveItem(FromCluster,ToCluster:integer;Item:integer);
var wvfrm:waveformf ;
    ave,count,sd,ssq,xmin,xmax: double;
    eudist,maxdist: extended;
    i,sp, dda, cmax: integer;
    divs:double;
begin
	FetchItemAt(item,wvfrm);
        //remove from
	for dda:=0 to numdatpts-1 do
	begin
		count:=sum[1,dda,FromCluster];
		ave:=sum[2,dda,FromCluster];
		ssq:=sum[6,dda,FromCluster];
		count:=count-1;

		if (count>0) then
                   begin
                     divs:=1/count;
                     ave:=ave-(wvfrm.wavformf[dda+firstdatpt]-ave)*divs;
                   end
                else
                   ave:=0;

		sum[2,dda,FromCluster]:=ave;
		ssq:=ssq-sqr(wvfrm.wavformf[dda+firstdatpt]-ave);
		sum[6,dda,FromCluster]:=ssq;
		if(count>1) then
                   begin
                     divs:=1/count;
                     sd:=ssq*count;
                   end
                else
                     sd:=0;
		sum[3,dda,FromCluster]:=sd;
		sum[1,dda,FromCluster]:=count;
	end;

        //add to
	for dda:=0 to numdatpts-1 do
	begin
		count:=sum[1,dda,ToCluster];
		ave:=sum[2,dda,ToCluster];
		ssq:=sum[6,dda,ToCluster];
		count:=count+1;

		if (count>0) then
                   begin
                      divs:=1/count;
                      ave:=ave+(wvfrm.wavformf[dda+firstdatpt]-ave)*divs;
                   end
                else
                   ave:=0;

		sum[2,dda,ToCluster]:=ave;
		ssq:=ssq+sqr(wvfrm.wavformf[dda+firstdatpt]-ave);
		sum[6,dda,ToCluster]:=ssq;
		if(count>1) then
                   begin
                     divs:=1/count;
                     sd:=ssq*count;
                   end
                else
                     sd:=0;

		sum[3,dda,ToCluster]:=sd;
		sum[1,dda,ToCluster]:=count;
	end;

end;
procedure DistributeGarbage;
var
	oldclust,sp,dda,ccl,jmin,count1:integer;
	wvfrm: waveformf;
	eudist, mindist: extended;//long double
	changed, aok: boolean;//, done=false;
  T1,T2:int64;
begin
  queryperformancecounter(t1);
	changed:=true;
	shuffled:=false;//shuffled is a global
	jmin:=-1;
	count1:=0;
	begin
     changed:=false;
	   for sp := maxlines downto 0 do
	   begin
	   	mindist:=10000000000000000000000.0;
	   	aok := FetchItemAt(sp, wvfrm);
	   	oldclust := iwork[sp];
	         if (oldclust = numclusters) then //if the spike is garbage
            begin
             for ccl:=0 to numclusters-1 do
             begin
              if (sum[1,1,ccl]>0) then
        	     begin
         	    	for dda:=0 to numdatpts-1 do
        	    	begin
                  data1[dda]:=wvfrm.wavformf[dda+firstdatpt];
                  data2[dda]:=sum[2,dda,ccl];
            		end;
                eudist:=SqrDistanceF(@data1[0],@data2[0],numdatpts);
               //eudist:=linDistance(@data1[0],@data2[0],numdatpts-1);

		          	if (eudist < mindist) then
          			begin
                     mindist:=eudist;
                     jmin:=ccl;
                     iscore[sp]:=round(eudist);
           			end;
               end;
		         end;
             if (jmin<>oldclust) and (jmin>=0) then //do the adjustments only when the jmin cluster is different from the current cluster
             begin
                  changed:=true;
                  shuffled:=true;
                  iwork[sp]:=jmin;
                  MoveItem(OldClust,Jmin,sp);
             end;
        	  end;
 	   end;
	end;
  queryperformancecounter(t2);
  form1.Tsum[3]:=form1.Tsum[3]+(T2-T1)
end;

initialization
begin
       //output form
        pform:=Tform.create(application);
        pform.Width:=500;
        pform.Height:=500;
        pform.Top:=200;
        pform.hide;
        graph:=Trfjchart.create(pform);
        graph.parent:=pform;
        graph.align:=alclient;
        graph.traces:=numclusters+1;
        graph.cols:=2;
        graph.Cols:=1+trunc(sqrt(graph.traces));
        for i:=1 to graph.traces do
        begin
            graph.trace[i].ymarginleft:=0;
            graph.trace[i].ymarginright:=0;
            graph.trace[i].xmargintop:=0;
            graph.trace[i].xmarginbottom:=0;
            graph.trace[i].drawxtop:=false;
            graph.trace[i].drawxbottom:=false;
            graph.trace[i].drawyleft:=false;
            graph.trace[i].drawyright:=false;
            graph.trace[i].yaxislegend:='';
            graph.trace[i].ygmin:=-1000;
            graph.trace[i].ygmax:=1000;
        end;
        graph.setuptraces;
        graph.drawaxes;
        graph.update;
        application.ProcessMessages;
        Graphupdate:=false;
end;





end.