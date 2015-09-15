unit wav_count;

//TODO    //fix for float

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,wavio, StdCtrls, rfjChart, ExtCtrls,cmaths,gr32,JvWavePlayer,
  Grids, AdvGrid, AdvSprd,nsp45, ComCtrls,bsutils,Audio,
  MPlayer,mmsystem,Cutils, ZipMstr,shlobj,filectrl,
  RXSpin, Color_calibrate,math, Gr32_Image,printers,janfx,gr32_layers,
  GIFCtrl, Menus,  CheckLst, ToolWin, Buttons,
  TB97, TB97Tlwn, Animate, Gr32_Transforms,gr32_filters, Placemnt,
  rfjchart_edit,gr32_rotlayer,stat,matrices, asgprev, ahofft,Zstring,
  ExtDlgs,pngimage,dateutils, Gauges,bmp2tiff,
  G32_Interface, BaseGrid,kmeans1,kmeans1f, csysutils,
  JvComponentBase, AudioIO, Mask, JvExMask, JvSpin, JvAppInst,StrUtils,psapi;

const maxrec=50000;
const maxbitmap=10000;
const maxclusters=250;


type Bindata = record
      Data: array[1..64] of Smallint;
      Time: Double;
end;

type Tslidemem=record
     max:integer;
     min:integer;
     position:integer;
end;


type idbrec=record
     offset:integer;
     time:integer;
     width:integer;
     height:integer;
     nextrec:integer;
end;

type clusterdata=record
       score:int64;
       width:integer;
       index:integer;
       cluster:integer;
end;

type tmyrecord = record
     Magic: integer;           // unsigned 32 bit
     Bitmapsize: integer;      // unsigned 32 bit
     edit1string: string[30];
     edit2string: string[30];
     edit3string: string[30];
end;

type bmparea=record
     topleft:Tpoint;
     bottomright:Tpoint;
     item:integer;
     time:double;
     cluster:integer;
     place:integer;
end;

type  Specdata = record
      Data: array[1..1000] of Smallint;
      Time: Double;
      Duration:double;
      Filename:string[64];
end;

type  SpecdataF = record
      Data: array[1..20] of double;
      Time: Double;
      Duration:double;
      Filename:string[64];
end;

type  Specdata2 = record
      Data: array[1..1500] of Smallint;
      Time: Double;
      Duration:double;
      Filename:string[64];
end;

Type Gatedata=record
      open :double;
      close:double;
      duration:double;
end;

type nc=record
      duration:double;
      meanfreq:double;
      meanfreqsd:double;
      modefreq:double;
      modefreqsd:double;
      wiener:double;
      wienersd:double;
      pitch:double;
      pitchsd:double;
end;

type ncdata=record
      meanfreq:double;
      modefreq:double;
      median:double;
      amean:double;
      gmean:double;
      wiener:double;
      pitch:double;
      firstpeak:double;
end;


type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    OpenDialog2: TOpenDialog;
    Audio1: TAudio;
    ZipMaster1: TZipMaster;
    Panel1: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog3: TSaveDialog;
    PopupMenu1: TPopupMenu;
    left1: TMenuItem;
    right1: TMenuItem;
    zoom1: TMenuItem;
    mark1: TMenuItem;
    PopupMenu2: TPopupMenu;
    edit1: TMenuItem;
    Settings1: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenWavZip1: TMenuItem;
    OpenCSVWAV1: TMenuItem;
    OpwnCSVZIP1: TMenuItem;
    ToolButton6: TToolButton;
    Exit1: TMenuItem;
    ToolWindow972: TToolWindow97;
    Panel4: TPanel;
    Button15: TButton;
    CheckBox26: TCheckBox;
    Panel13: TPanel;
    Button9: TButton;
    Label25: TLabel;

    Button21: TButton;
    Panel17: TPanel;
    Label3: TLabel;
    RxSpinEdit12: TRxSpinEdit;
    Button14: TButton;
    RxSpinEdit13: TRxSpinEdit;
    Label19: TLabel;
    Panel18: TPanel;
    Button26: TButton;
    Button27: TButton;
    RadioGroup2: TRadioGroup;
    Button22: TButton;
    ToolWindow976: TToolWindow97;
    Panel7: TPanel;
    Label22: TLabel;
    Label21: TLabel;
    CheckBox15: TCheckBox;
    Button16: TButton;
    Button18: TButton;
    Button20: TButton;
    CheckBox18: TCheckBox;
    CheckBox22: TCheckBox;
    ComboBox5: TComboBox;
    ComboBox3: TComboBox;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolWindow9712: TToolWindow97;
    Panel16: TPanel;
    RxGIFAnimator2: TRxGIFAnimator;
    Animator: TRxGIFAnimator;
    RxGIFAnimator1: TRxGIFAnimator;
    RxGIFAnimator3: TRxGIFAnimator;
    Bevel7: TBevel;
    CheckBox27: TCheckBox;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    ToolWindow9713: TToolWindow97;
    ToolBar2: TToolBar;
    BitBtn15: TBitBtn;
    ToolWindow9715: TToolWindow97;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    About1: TMenuItem;
    Button30: TButton;
    BitBtn14: TBitBtn;
    OpenDialog3: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel5: TPanel;
    rfjChart1: TrfjChart;
    Panel9: TPanel;
    ScrollBar2: TScrollBar;
    ScrollBar6: TScrollBar;
    Panel10: TPanel;
    ScrollBar1: TScrollBar;
    Color_calibrate2: TColor_calibrate;
    TabSheet2: TTabSheet;
    rfjChart2: TrfjChart;
    ScrollBar3: TScrollBar;
    Panel15: TPanel;
    ScrollBar5: TScrollBar;
    TabSheet12: TTabSheet;
    TabSheet14: TTabSheet;
    Memo1: TMemo;
    Panel3: TPanel;
    Button24: TButton;
    TabSheet15: TTabSheet;
    Memo2: TMemo;
    Panel8: TPanel;
    zipfname: TLabel;
    Bevel11: TBevel;
    Label26: TLabel;
    Bevel5: TBevel;
    Bevel4: TBevel;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    MediaPlayer1: TMediaPlayer;
    CheckBox31: TCheckBox;
    RxSpinEdit17: TRxSpinEdit;
    CheckBox1: TCheckBox;
    Button2: TButton;
    Button6: TButton;
    Button3: TButton;
    CheckBox4: TCheckBox;
    Panel2: TPanel;
    Panel19: TPanel;
    CheckBox23: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox36: TCheckBox;
    CheckBox16: TCheckBox;
    TabSheet3: TTabSheet;
    ImgView321: TImgView32;
    Panel20: TPanel;
    RxSpinEdit5: TRxSpinEdit;
    RxSpinEdit23: TRxSpinEdit;
    Timer1: TTimer;
    SaveDialog4: TSaveDialog;
    Panel11: TPanel;
    Splitter1: TSplitter;
    Panel21: TPanel;
    ToolBar3: TToolBar;
    Panel12: TPanel;
    BitBtn16: TBitBtn;
    AdvSpreadGrid1: TAdvSpreadGrid;
    Splitter2: TSplitter;
    Panel22: TPanel;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    rfjChart3: TrfjChart;
    Panel23: TPanel;
    Label18: TLabel;
    Label24: TLabel;
    RxSpinEdit25: TRxSpinEdit;
    RxSpinEdit26: TRxSpinEdit;
    Button31: TButton;
    Button35: TButton;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Panel24: TPanel;
    Button36: TButton;
    Panel25: TPanel;
    AdvStringGrid1: TAdvStringGrid;
    PageControl3: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Bevel1: TBevel;
    CheckBox11: TCheckBox;
    GroupBox6: TGroupBox;
    Label15: TLabel;
    RxSpinEdit7: TRxSpinEdit;
    CheckBox13: TCheckBox;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label16: TLabel;
    RxSpinEdit8: TRxSpinEdit;
    RxSpinEdit20: TRxSpinEdit;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    RxSpinEdit22: TRxSpinEdit;
    TabSheet10: TTabSheet;
    CheckBox7: TCheckBox;
    GroupBox7: TGroupBox;
    Label13: TLabel;
    Label12: TLabel;
    Label9: TLabel;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    GroupBox18: TGroupBox;
    TabSheet11: TTabSheet;
    TabSheet13: TTabSheet;
    CheckBox37: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox38: TCheckBox;
    TabSheet16: TTabSheet;
    GroupBox15: TGroupBox;
    CheckBox30: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    RxSpinEdit18: TRxSpinEdit;
    Button25: TButton;
    Button28: TButton;
    TabSheet17: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Button4: TButton;
    Button5: TButton;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    RxSpinEdit1: TRxSpinEdit;
    CheckBox39: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn22: TBitBtn;
    ToolButton12: TToolButton;
    FontDialog1: TFontDialog;
    Panel26: TPanel;
    Label17: TLabel;
    Label29: TLabel;
    RxSpinEdit27: TRxSpinEdit;
    RxSpinEdit28: TRxSpinEdit;
    Button37: TButton;
    Button38: TButton;
    rfjChart6: TrfjChart;
    Panel27: TPanel;
    Button39: TButton;
    Button40: TButton;
    CheckBox29: TCheckBox;
    Label33: TLabel;
    Label34: TLabel;
    RxGIFAnimator4: TRxGIFAnimator;
    GroupBox5: TGroupBox;
    RxSpinEdit32: TRxSpinEdit;
    RxSpinEdit31: TRxSpinEdit;
    RxSpinEdit30: TRxSpinEdit;
    RxSpinEdit29: TRxSpinEdit;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    CheckBox40: TCheckBox;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    CheckBox43: TCheckBox;
    Button41: TButton;
    CheckBox44: TCheckBox;
    CheckBox46: TCheckBox;
    GroupBox9: TGroupBox;
    RxSpinEdit33: TRxSpinEdit;
    CheckBox45: TCheckBox;
    Label39: TLabel;
    RxSpinEdit34: TRxSpinEdit;
    Label40: TLabel;
    RxSpinEdit35: TRxSpinEdit;
    RxSpinEdit36: TRxSpinEdit;
    Label41: TLabel;
    Label42: TLabel;
    SaveDialog5: TSaveDialog;
    TabSheet18: TTabSheet;
    AdvSpreadGrid3: TAdvSpreadGrid;
    Button43: TButton;
    AdvPreviewDialog1: TAdvPreviewDialog;
    GroupBox12: TGroupBox;
    ComboBox6: TComboBox;
    Label44: TLabel;
    RxSpinEdit37: TRxSpinEdit;
    Label45: TLabel;
    Label46: TLabel;
    GroupBox14: TGroupBox;
    Label11: TLabel;
    CheckBox25: TCheckBox;
    RxSpinEdit4: TRxSpinEdit;
    RxSpinEdit21: TRxSpinEdit;
    Label14: TLabel;
    Label43: TLabel;
    SaveDialog6: TSaveDialog;
    Button44: TButton;
    Button46: TButton;
    CheckBox48: TCheckBox;
    Label47: TLabel;
    Panel28: TPanel;
    Panel6: TPanel;
    Bevel8: TBevel;
    Label10: TLabel;
    Label20: TLabel;
    RxSpinEdit9: TRxSpinEdit;
    rfjChart4: TrfjChart;
    Button8: TButton;
    RxSpinEdit24: TRxSpinEdit;
    Label30: TLabel;
    rfjChart7: TrfjChart;
    CheckBox49: TCheckBox;
    Button47: TButton;
    Button48: TButton;
    TabSheet19: TTabSheet;
    ToolWindow978: TToolWindow97;
    GroupBox16: TGroupBox;
    RadioGroup4: TRadioGroup;
    Button29: TButton;
    GroupBox17: TGroupBox;
    Button12: TButton;
    CheckBox14: TCheckBox;
    Button13: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    BitBtn23: TBitBtn;
    BitBtn24: TBitBtn;
    GroupBox19: TGroupBox;
    RxSpinEdit15: TRxSpinEdit;
    Label27: TLabel;
    Label28: TLabel;
    Button17: TButton;
    Button10: TButton;
    CheckBox17: TCheckBox;
    GroupBox20: TGroupBox;
    Button42: TButton;
    Button19: TButton;
    Button45: TButton;
    Button49: TButton;
    GroupBox10: TGroupBox;
    Label31: TLabel;
    RxSpinEdit16: TRxSpinEdit;
    GroupBox13: TGroupBox;
    Memo3: TMemo;
    BitBtn25: TBitBtn;
    Button51: TButton;
    AdvStringGrid2: TAdvStringGrid;
    CheckBox21: TCheckBox;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel14: TPanel;
    Button52: TButton;
    Button53: TButton;
    CheckBox50: TCheckBox;
    RadioGroup3: TRadioGroup;
    Button59: TButton;
    CheckBox51: TCheckBox;
    CheckBox47: TCheckBox;
    RxSpinEdit6: TRxSpinEdit;
    Label32: TLabel;
    Label48: TLabel;
    CheckBox12: TCheckBox;
    CheckBox52: TCheckBox;
    CheckBox53: TCheckBox;
    GroupBox21: TGroupBox;
    CheckBox28: TCheckBox;
    Button7: TButton;
    TabSheet20: TTabSheet;
    rfjChart8: TrfjChart;
    rfjChart9: TrfjChart;
    RxSpinEdit38: TRxSpinEdit;
    Label49: TLabel;
    GroupBox22: TGroupBox;
    CheckBox54: TCheckBox;
    Label50: TLabel;
    Label51: TLabel;
    CheckBox55: TCheckBox;
    Button11: TButton;
    Button60: TButton;
    TabSheet21: TTabSheet;
    GroupBox24: TGroupBox;
    Label56: TLabel;
    GroupBox25: TGroupBox;
    CheckBox60: TCheckBox;
    Label58: TLabel;
    RxSpinEdit43: TRxSpinEdit;
    CheckBox61: TCheckBox;
    Label59: TLabel;
    RxSpinEdit44: TRxSpinEdit;
    GroupBox26: TGroupBox;
    CheckBox57: TCheckBox;
    CheckBox59: TCheckBox;
    Label54: TLabel;
    RxSpinEdit40: TRxSpinEdit;
    RxSpinEdit42: TRxSpinEdit;
    Label57: TLabel;
    Button61: TButton;
    BitBtn19: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn17: TBitBtn;
    Label52: TLabel;
    Gauge1: TGauge;
    GroupBox27: TGroupBox;
    Button50: TButton;
    CheckBox58: TCheckBox;
    RxSpinEdit39: TRxSpinEdit;
    Label53: TLabel;
    TabSheet22: TTabSheet;
    ImgView322: TImgView32;
    SavePictureDialog1: TSavePictureDialog;
    OpenPictureDialog2: TOpenPictureDialog;
    CheckBox63: TCheckBox;
    CheckBox64: TCheckBox;
    Label55: TLabel;
    CheckBox65: TCheckBox;
    Panel30: TPanel;
    RxSpinEdit14: TRxSpinEdit;
    Label23: TLabel;
    TabSheet23: TTabSheet;
    GroupBox28: TGroupBox;
    Label60: TLabel;
    Label62: TLabel;
    Label65: TLabel;
    Button62: TButton;
    RxSpinEdit46: TRxSpinEdit;
    RxSpinEdit47: TRxSpinEdit;
    ComboBox7: TComboBox;
    Panel29: TPanel;
    Label63: TLabel;
    ImgView323: TImgView32;
    CheckBox62: TCheckBox;
    CheckBox66: TCheckBox;
    ComboBox8: TComboBox;
    GroupBox8: TGroupBox;
    CheckBox67: TCheckBox;
    CheckBox68: TCheckBox;
    RxSpinEdit48: TRxSpinEdit;
    RxSpinEdit49: TRxSpinEdit;
    CheckBox6: TCheckBox;
    rfjChart10: TrfjChart;
    Button66: TButton;
    GroupBox29: TGroupBox;
    Panel31: TPanel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Panel32: TPanel;
    Label69: TLabel;
    Label70: TLabel;
    RxSpinEdit19: TRxSpinEdit;
    Panel33: TPanel;
    Button67: TButton;
    RxSpinEdit50: TRxSpinEdit;
    Button68: TButton;
    Panel34: TPanel;
    Button69: TButton;
    Label71: TLabel;
    Label72: TLabel;
    CheckBox69: TCheckBox;
    Button64: TButton;
    Button65: TButton;
    RxSpinEdit45: TRxSpinEdit;
    RxSpinEdit41: TRxSpinEdit;
    ScrollButton: TSpeedButton;
    Button63: TButton;
    Button23: TButton;
    GroupBox30: TGroupBox;
    CheckBox56: TCheckBox;
    Label61: TLabel;
    GroupBox3: TGroupBox;
    GroupBox31: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    RxSpinEdit3: TRxSpinEdit;
    RxSpinEdit2: TRxSpinEdit;
    ComboBox4: TComboBox;
    CheckBox24: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox70: TCheckBox;
    CheckBox71: TCheckBox;
    RxSpinEdit51: TRxSpinEdit;
    Button70: TButton;
    CheckBox72: TCheckBox;
    Panel35: TPanel;
    Label64: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Panel36: TPanel;
    rfjChart5: TrfjChart;
    Panel37: TPanel;
    rfjChart11: TrfjChart;
    Button71: TButton;
    Label75: TLabel;
    RxSpinEdit52: TRxSpinEdit;
    RxSpinEdit54: TRxSpinEdit;
    Label77: TLabel;
    Label76: TLabel;
    RxSpinEdit53: TRxSpinEdit;
    Label78: TLabel;
    Label79: TLabel;
    RxSpinEdit55: TRxSpinEdit;
    Label80: TLabel;
    RxSpinEdit56: TRxSpinEdit;
    Button73: TButton;
    Label81: TLabel;
    Label82: TLabel;
    Button74: TButton;
    CheckBox73: TCheckBox;
    TabSheet24: TTabSheet;
    CheckBox74: TCheckBox;
    RxSpinEdit57: TRxSpinEdit;
    RxSpinEdit58: TRxSpinEdit;
    ScrollBar4: TScrollBar;
    Button75: TButton;
    RxSpinEdit59: TRxSpinEdit;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Memo4: TMemo;
    Button76: TButton;
    GroupBox32: TGroupBox;
    Button72: TButton;
    CheckBox75: TCheckBox;
    CheckBox76: TCheckBox;
    CheckBox77: TCheckBox;
    CheckBox78: TCheckBox;
    CheckBox79: TCheckBox;
    Button77: TButton;
    RadioGroup5: TRadioGroup;
    Button78: TButton;
    Button79: TButton;
    CheckBox80: TCheckBox;
    FormStorage1: TFormStorage;
    TabSheet25: TTabSheet;
    Panel38: TPanel;
    Panel39: TPanel;
    Button82: TButton;
    Label100: TLabel;
    Panel40: TPanel;
    Panel41: TPanel;
    Panel42: TPanel;
    Panel43: TPanel;
    ImgView324: TImgView32;
    Memo5: TMemo;
    GroupBox33: TGroupBox;
    RxSpinEdit76: TRxSpinEdit;
    OpenDialog4: TOpenDialog;
    Panel48: TPanel;
    Panel49: TPanel;
    RxSpinEdit60: TRxSpinEdit;
    CheckBox83: TCheckBox;
    Image321: TImage32;
    Panel50: TPanel;
    Panel51: TPanel;
    RxSpinEdit68: TRxSpinEdit;
    Label91: TLabel;
    RxSpinEdit61: TRxSpinEdit;
    RxSpinEdit62: TRxSpinEdit;
    CheckBox81: TCheckBox;
    CheckBox82: TCheckBox;
    Label96: TLabel;
    RxSpinEdit64: TRxSpinEdit;
    rfjChart12: TrfjChart;
    CheckBox86: TCheckBox;
    Button85: TButton;
    Label92: TLabel;
    RxSpinEdit65: TRxSpinEdit;
    CheckBox90: TCheckBox;
    RxSpinEdit71: TRxSpinEdit;
    Label93: TLabel;
    RxSpinEdit63: TRxSpinEdit;
    CheckBox87: TCheckBox;
    Button87: TButton;
    Label104: TLabel;
    Button89: TButton;
    CheckBox91: TCheckBox;
    AudioOut1: TAudioOut;
    Label90: TLabel;
    Label89: TLabel;
    TabSheet26: TTabSheet;
    CheckBox92: TCheckBox;
    JvSpinEdit1: TJvSpinEdit;
    JvSpinEdit2: TJvSpinEdit;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;

    CheckBox93: TCheckBox;
    CheckBox94: TCheckBox;
    Label110: TLabel;
    JvSpinEdit3: TJvSpinEdit;
    CheckBox95: TCheckBox;
    JvSpinEdit4: TJvSpinEdit;
    CheckBox96: TCheckBox;
    JvSpinEdit5: TJvSpinEdit;
    Bevel: TBevel;
    Bevel14: TBevel;
    Button56: TButton;
    //JvWavePlayer2: TJvWavePlayer;
    EXTERNAL_DATA: TTabSheet;
    Panel52: TPanel;
    Panel53: TPanel;
    Panel54: TPanel;
    Panel55: TPanel;
    ImgView325: TImgView32;
    Button57: TButton;
    //JvWavePlayer1: TJvWavePlayer;
    ImgView326: TImgView32;
    Button58: TButton;
    OpenDialog5: TOpenDialog;
    RxSpinEdit11: TRxSpinEdit;
    RxSpinEdit77: TRxSpinEdit;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Panel56: TPanel;
    Panel47: TPanel;
    Bevel10: TBevel;
    Label95: TLabel;
    Bevel13: TBevel;
    Bevel9: TBevel;
    RxSpinEdit67: TRxSpinEdit;
    Button88: TButton;
    RxSpinEdit69: TRxSpinEdit;
    Button90: TButton;
    RxSpinEdit73: TRxSpinEdit;
    RxSpinEdit72: TRxSpinEdit;
    Panel46: TPanel;
    Label101: TLabel;
    Bevel12: TBevel;
    Button86: TButton;
    CheckBox88: TCheckBox;
    Button54: TButton;
    Panel45: TPanel;
    Bevel2: TBevel;
    Label94: TLabel;
    Label103: TLabel;
    Label105: TLabel;
    Button84: TButton;
    RxSpinEdit74: TRxSpinEdit;
    RxSpinEdit66: TRxSpinEdit;
    CheckBox85: TCheckBox;
    CheckBox84: TCheckBox;
    CheckBox89: TCheckBox;
    RxSpinEdit75: TRxSpinEdit;
    Panel44: TPanel;
    Label98: TLabel;
    Label99: TLabel;
    Bevel3: TBevel;
    Label97: TLabel;
    Label102: TLabel;
    Bevel6: TBevel;
    Button80: TButton;
    Button81: TButton;
    Button83: TButton;
    RxSpinEdit70: TRxSpinEdit;
    Button55: TButton;
    JvAppInstances1: TJvAppInstances;

    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Panel57: TPanel;
    Button92: TButton;

    ScrollBar7: TScrollBar;
    jvwaveplayer1: TJvWavePlayer;
    RxSpinEdit10: TRxSpinEdit;
    Bevel15: TBevel;
    CheckBox97: TCheckBox;
    JvSpinEdit6: TJvSpinEdit;
    Label117: TLabel;
    Label118: TLabel;
    CheckBox98: TCheckBox;
    Label119: TLabel;
    CheckBox99: TCheckBox;
    GroupBox11: TGroupBox;
    CheckBox19: TCheckBox;
    DUMPBMP: TCheckBox;
    Bevel16: TBevel;
    useharddisk: TCheckBox;
    Label120: TLabel;
    Label121: TLabel;
    CheckBox100: TCheckBox;
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    //procedure Button4Click(Sender: TObject);
    procedure RxSpinEdit3Change(Sender: TObject);
    procedure RxSpinEdit2Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure RxSpinEdit4Change(Sender: TObject);
    procedure RxSpinEdit5Change(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RxSpinEdit7Change(Sender: TObject);
    procedure RxSpinEdit8Change(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    //procedure rfjChart1click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    //procedure RxSpinEdit11Change(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure RxSpinEdit12Change(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    //procedure rfjChart1resize(Sender: TObject);
    procedure rfjChart2resize(Sender: TObject);
    procedure rfjChart3resize(Sender: TObject);
    procedure Color_calibrate1Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure rfjChart3mousedown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure rfjChart5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure rfjChart5resize(Sender: TObject);
    procedure rfjChart3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure RxSpinEdit13Change(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    //procedure rfjChart1MouseMove(Sender: TObject; Shift: TShiftState; X,
    //  Y: Integer; Layer: TCustomLayer);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure rfjChart2click(Sender: TObject);
    procedure rfjChart3click(Sender: TObject);
    procedure ImgView321Click(Sender: TObject);
    procedure rfjChart4click(Sender: TObject);
    procedure rfjChart5click(Sender: TObject);
    procedure rfjChart2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure rfjChart4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure CheckBox19Click(Sender: TObject);
    procedure CheckBox20Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure rfjChart4resize(Sender: TObject);
    procedure CheckBox24Click(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    //procedure rfjChart1mousedown(Sender: TObject; Button: TMouseButton;
    //  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox5Click(Sender: TObject);
    procedure CheckBox25Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxSpinEdit13TopClick(Sender: TObject);
    procedure left1Click(Sender: TObject);
    procedure right1Click(Sender: TObject);
    procedure zoom1Click(Sender: TObject);
    procedure ScrollBar6Change(Sender: TObject);
    procedure CheckBox23Click(Sender: TObject);
    procedure mark1Click(Sender: TObject);
    procedure AdvSpreadGrid1ClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure RadioGroup3Click(Sender: TObject);
    procedure CheckBox33Click(Sender: TObject);
    procedure CheckBox34Click(Sender: TObject);
    procedure CheckBox35Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    //procedure rfjChart1dblclick(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure rfjChart2mousedown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    //procedure rfjChart1MouseUp(Sender: TObject; Button: TMouseButton;
    //  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure Button29Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Panel15GetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure Panel12GetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure Panel3GetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure Panel3DockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
    procedure Panel3UnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure Panel12UnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure Panel12DockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
    procedure Panel17GetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure RxSpinEdit19Change(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure OpenWavZip1Click(Sender: TObject);
    procedure OpenCSVWAV1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure OpwnCSVZIP1Click(Sender: TObject);
    procedure rfjChart2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure rfjChart3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure PlayAll1Click(Sender: TObject);
    procedure PalySelection1Click(Sender: TObject);
    procedure Print2Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure AdvSpreadGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure About1Click(Sender: TObject);
    procedure rfjChart5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure Button30Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure RxSpinEdit20Change(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure RxSpinEdit21Change(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure RxGIFAnimator4Click(Sender: TObject);
    procedure ToolBar1Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure ImgView321MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ImgView321MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure ImgView321MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure RxSpinEdit23Change(Sender: TObject);
    procedure RxSpinEdit22Change(Sender: TObject);
    procedure RxSpinEdit24Change(Sender: TObject);
    procedure CheckBox38Click(Sender: TObject);
    procedure CheckBox37Click(Sender: TObject);
    procedure RxSpinEdit26Change(Sender: TObject);
    procedure RxSpinEdit25Change(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn23Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure RxSpinEdit28Change(Sender: TObject);
    procedure RxSpinEdit27Change(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure Button40Click(Sender: TObject);
    procedure CheckBox29Click(Sender: TObject);
    procedure RxSpinEdit29Change(Sender: TObject);
    procedure RxSpinEdit30Change(Sender: TObject);
    procedure RxSpinEdit31Change(Sender: TObject);
    procedure RxSpinEdit32Change(Sender: TObject);
    procedure CheckBox40Click(Sender: TObject);
    procedure CheckBox41Click(Sender: TObject);
    procedure CheckBox42Click(Sender: TObject);
    procedure CheckBox43Click(Sender: TObject);
    procedure AdvSpreadGrid1SelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure AdvSpreadGrid1CellChanging(Sender: TObject; OldRow, OldCol,
      NewRow, NewCol: Integer; var Allow: Boolean);
    procedure AdvSpreadGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox45Click(Sender: TObject);
    procedure RxSpinEdit33Change(Sender: TObject);
    procedure CheckBox46Click(Sender: TObject);
    procedure RxSpinEdit34Change(Sender: TObject);
    procedure Button42Click(Sender: TObject);
    procedure Button43Click(Sender: TObject);
    procedure CheckBox47Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure RxSpinEdit37Change(Sender: TObject);
    procedure Button44Click(Sender: TObject);
    procedure Button45Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure Button46Click(Sender: TObject);
    procedure CheckBox26Click(Sender: TObject);
    procedure rfjChart7click(Sender: TObject);
    procedure rfjChart7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure Button47Click(Sender: TObject);
    procedure Button48Click(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn25Click(Sender: TObject);
    procedure BitBtn26Click(Sender: TObject);
    procedure Button49Click(Sender: TObject);
    procedure CheckBox49Click(Sender: TObject);
    procedure Button50Click(Sender: TObject);
    procedure Button51Click(Sender: TObject);
    procedure CheckBox21Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure AdvStringGrid2ClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure Button53Click(Sender: TObject);
    procedure Button52Click(Sender: TObject);
    procedure RxSpinEdit21BottomClick(Sender: TObject);
    procedure RxSpinEdit21TopClick(Sender: TObject);
    procedure Button54Click(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure Button55Click(Sender: TObject);
    procedure Button57Click(Sender: TObject);
    procedure Button56Click(Sender: TObject);
    procedure Button59Click(Sender: TObject);
    procedure CheckBox51Click(Sender: TObject);
    procedure Button58Click(Sender: TObject);
    procedure Splitter3Moved(Sender: TObject);
    //procedure rfjChart9MouseMove(Sender: TObject; Shift: TShiftState; X,
    //  Y: Integer; Layer: TCustomLayer);
    //procedure rfjChart8MouseMove(Sender: TObject; Shift: TShiftState; X,
    //  Y: Integer; Layer: TCustomLayer);
    //procedure rfjChart9click(Sender: TObject);
    //procedure rfjChart8click(Sender: TObject);
    procedure RxSpinEdit38Change(Sender: TObject);
    procedure CheckBox55Click(Sender: TObject);
    procedure CheckBox54Click(Sender: TObject);
    procedure GroupBox18Click(Sender: TObject);
    procedure GroupBox22Click(Sender: TObject);
    procedure Button60Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure Button61Click(Sender: TObject);
    procedure TabSheet21Show(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox56Click(Sender: TObject);
    procedure CheckBox58Click(Sender: TObject);
    procedure CheckBox62Click(Sender: TObject);
    procedure ImgView322MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure ImgView322Click(Sender: TObject);
    procedure ImgView322DblClick(Sender: TObject);
    procedure Button62Click(Sender: TObject);
    procedure Button63Click(Sender: TObject);
    procedure RxSpinEdit47Change(Sender: TObject);
    procedure Button64Click(Sender: TObject);
    procedure Button65Click(Sender: TObject);
    procedure RxSpinEdit41Change(Sender: TObject);
    procedure RxSpinEdit45Change(Sender: TObject);
    procedure CheckBox63Click(Sender: TObject);
    procedure RxSpinEdit46Change(Sender: TObject);
    procedure CheckBox64Click(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure JvThread1Execute(Sender: TObject; params: Pointer);
    procedure CheckBox66Click(Sender: TObject);
    procedure CheckBox67Click(Sender: TObject);
    procedure RxSpinEdit48Change(Sender: TObject);
    procedure RxSpinEdit49Change(Sender: TObject);
    procedure CheckBox68Click(Sender: TObject);
    procedure Button66Click(Sender: TObject);
    procedure Button69Click(Sender: TObject);
    procedure Button67Click(Sender: TObject);
    procedure Button68Click(Sender: TObject);
    procedure RxSpinEdit50Change(Sender: TObject);
    procedure CheckBox69Click(Sender: TObject);
   procedure History1Click(Sender: TObject);
    procedure ScrollButtonClick(Sender: TObject);
    procedure CheckBox71Click(Sender: TObject);
    procedure RxSpinEdit51Change(Sender: TObject);
    procedure Button70Click(Sender: TObject);
    procedure Button71Click(Sender: TObject);
    procedure RxSpinEdit52Change(Sender: TObject);
    procedure RxSpinEdit54Change(Sender: TObject);
    procedure RxSpinEdit53Change(Sender: TObject);
    procedure Button72Click(Sender: TObject);
    procedure RxSpinEdit56Change(Sender: TObject);
    procedure RxSpinEdit55Change(Sender: TObject);
    procedure Button73Click(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure Button74Click(Sender: TObject);
    procedure Button75Click(Sender: TObject);
    procedure CheckBox74Click(Sender: TObject);
    procedure CheckBox73Click(Sender: TObject);
    procedure Button76Click(Sender: TObject);
    procedure JvTimeLimit1Expire(Sender: TObject);
    procedure CheckBox75Click(Sender: TObject);
    procedure CheckBox76Click(Sender: TObject);
    procedure CheckBox77Click(Sender: TObject);
    procedure Button77Click(Sender: TObject);
    procedure RadioGroup5Click(Sender: TObject);
    procedure Button78Click(Sender: TObject);
    procedure Button79Click(Sender: TObject);
    procedure Button80Click(Sender: TObject);
    procedure Button81Click(Sender: TObject);
    procedure RxSpinEdit60Change(Sender: TObject);
    procedure rfjChart12click(Sender: TObject);
    procedure RxSpinEdit63Change(Sender: TObject);
    procedure rfjChart12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure Button82Click(Sender: TObject);
    procedure Button83Click(Sender: TObject);
    procedure Button84Click(Sender: TObject);
    procedure Button85Click(Sender: TObject);
    procedure Button86Click(Sender: TObject);
    procedure ImgView324DblClick(Sender: TObject);
    procedure ImgView324MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure ImgView324Click(Sender: TObject);
    procedure RxSpinEdit68Change(Sender: TObject);
    procedure Button88Click(Sender: TObject);
    procedure Button89Click(Sender: TObject);
    procedure CheckBox84Click(Sender: TObject);
    procedure CheckBox85Click(Sender: TObject);
    procedure Button90Click(Sender: TObject);
    procedure RxSpinEdit64Change(Sender: TObject);
    procedure Button87Click(Sender: TObject);
    procedure RxSpinEdit71Change(Sender: TObject);
    procedure ImgView324MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure CheckBox81Click(Sender: TObject);
    procedure RxSpinEdit76Change(Sender: TObject);
    function AudioOut1FillBuffer(Buffer: PAnsiChar; var Size: Integer): Boolean;
    procedure RxSpinEdit11Change(Sender: TObject);
    procedure RxSpinEdit77Change(Sender: TObject);
    procedure ImgView325MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure Button92Click(Sender: TObject);
    procedure ScrollBar7Change(Sender: TObject);
    procedure CheckBox91Click(Sender: TObject);
    procedure CheckBox97Click(Sender: TObject);
    procedure JvSpinEdit6Change(Sender: TObject);
    procedure CheckBox98Click(Sender: TObject);
    procedure ImgView325MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure CheckBox78Click(Sender: TObject);
    procedure RxSpinEdit16Change(Sender: TObject);
    procedure usememoryClick(Sender: TObject);
    procedure useharddiskClick(Sender: TObject);
    procedure CheckBox100Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    BinEvent:array[1..1] of specdata;
    binoutfile:string;
    binfile:file;
    binfileisopen:boolean;
    wav_in:wavefile;
    succes:boolean;
    wavdata:array of smallint;
    tempwav:array of smallint;
    outbuffer:array of smallint;
    Nofsamples,Nofchannels,Rate,Bitspersample:integer;
    slen3:extended;
    sample:wavefilesample;
    abovelevel:integer;
    ratio:double;
    HPTaps:Integer;
    HPCoeff:array[0..999] of double;
    HPCoeffS:array[0..999] of float;
    HPfreq:double;
    HPState:TNSPFirState;
    HPWindow: TNSP_WindowType;
    HPnormal:integer;
    HPswitch:boolean;
    HPchannelstate:array[1..1] of TNSPFirState;
    LPTaps:Integer;
    LPCoeff:array[0..999] of double;
    LPCoeffs:array[0..999] of float;
    LPfreq:double;
    LPState:TNSPFirState;
    LPWindow: TNSP_WindowType;
    LPnormal:integer;
    LPswitch:boolean;
    LPchannelstate:array[1..1] of TNSPFirState;
    numfiles:integer;
    path:string;
    filepath:string;
    Trackavg:double;
    Trackdatamax:integer;
    data:TIntegerVector;
    DoIt:         Boolean;
    TotUncomp, TotComp: Cardinal;
    TotalSize1, TotalProgress1, TotalSize2, TotalProgress2: Int64;
    zipfilename:string;
    zip:boolean;
    stop:boolean;
    fromCSV:boolean;
    currentfile:string;
    runningavg:double;
    runningavgcount:integer;
    slice:array[0..4096] of double;
    shortslice:array[0..4096] of smallint;
    islice:array[0..4096] of smallint;
    power:array[0..4096] of double;
    ceps:array[0..2048] of double;
    //sortpower:array[0..4096] of double;
    freq:array[0..4096] of double;
    count2over:boolean;
    count2under:boolean;
    count2peak:boolean;
    startsample,eindsample:integer;
    prevstartsample,preveindsample:integer;
    currentrow,currentcol:integer;
    fileread:boolean;
    env_calc:boolean;
    filefiltered:boolean;
    points_at_trace:integer;
    fbmp2:Tbitmap32;
    readingdisk:boolean;
    overrule:boolean;
    mousedownx:integer;
    mouseupx:integer;
    mousedowny:integer;
    mouseupy:integer;
    pageprint:integer;
    zoomymax,zoomymin:integer;
    lefmousebuttonisdown:boolean;
    mx,my:integer;  //remember mouse positions
    s1,s2:integer;  //x-positions for spectrum correltations
    sonogram_lut:Tlut8;
    lastrowclicked:integer;
    slide:array[1..4] of Tscrollbar;
    slide2:array[1..4] of Tscrollbar;
    slidestore:array[1..4] of Tslidemem;
    slidestore2:array[1..4] of Tslidemem;
    slidepanel:array[1..4] of Tpanel;
    slidepanel2:array[1..4] of Tpanel;
    colors:Tcolor_calibrate;
    ebuffer:array of integer;
    channelcount:integer;
    echannel,wchannel,gchannel,schannel:integer;
    wchannel_settings:Tbmpmetrics;
    echannel_settings:Tbmpmetrics;
    gchannel_settings:Tbmpmetrics;
    schannel_settings:Tbmpmetrics;
    recalcsonogram:boolean;
    clickprocessing:boolean;
    slideposition:array[1..8] of integer;
    L1,L2: TRotLayer;
    dobitmapmove:boolean;
    bmm_x,bmm_y:integer;
    wavmax:integer;
    gridrows:integer;
    lockupdate:boolean;
    samplesperbin:double;
    samplesperresbin:double;
    AdjustTime:boolean;
    Hrs,Min,Sec:String;
    Day,Month,Year:String;
    programhome:string;
    mouseisdown:boolean;
    //
    PNG: TPNGObject;
    mynewfilename: string;
    FStream: TmemoryStream;
    FHead: TMyRecord;
    FFile: TFileStream;
    save_db:boolean;
    save_bin:boolean;
    processing:boolean;
    testbuffer:array of integer;
    xoffset:integer;
    datetime_start:Tdatetime;
    sumlist:array[1..maxrec] of string;
    sumlistlookup:array[1..maxrec] of integer;
    sumclickrow,sumclickcol,sumclicknumber:integer;
    pcol,prow,pcols:integer;
    ptotalcount:integer;
    prr,pcc:integer;
    pbrows,pbcols:integer;
    printcount:integer;
    ziphome:String;
    zipname:string;
    fromfile,tofile:string;
    magrect:integer;
    Undolevel:integer;
    meanpower:array[0..4096] of double;
    spectrumlastx,spectrumlasty:integer;
    firstpeak,highpeak:double;
    medianspect:double;
    peakcounter:integer;
    peakdata:array [1..maxclusters] of double;
    clip32:Tbitmap32;
    clip:Tbitmap;
    spec:file;
    specf:file;
    extspec:file;
    speccols:boolean;
    firstshow:boolean;
    // km-vars down here
    idb_written,spec_written:integer;
    dumdata:array of waveform;
    dumdata2:array of waveform;
    dumdataf:array of waveformf;
    dumdata2f:array of waveformf;
    old_dumdata:array of waveform;
    tsum:array[1..100] of int64;
    idbdata:array[1..maxrec] of idbrec;
    clusterinfo:array of clusterdata;
    idbname:string;
    idbbmp:Tbitmap32;
    idbsize:integer;
    idb:file;
    extidb:file;
    idbheight:integer;
    specdatfile:string;
    lcount:integer;
    specreclen:integer;
    selection: array [1..maxrec] of boolean;
    area:array of array of bmparea;
    areacounter:array[0..maxclusters] of integer;

    //extarea:array of array of bmparea;
    extarea:array[0..maxclusters,0..maxbitmap] of bmparea;
    extareacounter:array[0..maxclusters] of integer;

    //areaindex:array[1..maxrec] of integer;
    //areaindexcounter:integer;
    //areacounter:integer;
    areapointer:integer;
    mx1,my1:integer;
    mx2,my2:integer;
    pmx1,pmy1:integer;
    pmx2,pmy2:integer;
    imageselectionfile,specselectionfile:string;
    currentitem,previtem:integer;
    idbbinhis:array [1..5000] of integer;
    bit:array of byte;
    totalwidth:integer;
    imagefileisopen:boolean;
    greyscale:array[0..255] of Tcolor32;
    havesum:boolean;
    showbmp:array[0..maxclusters] of Tbitmap32;
    idbimg:array of byte;
    idbimage:array of Tbitmap32;
    currentx1,currenty1,currentx2,currenty2:integer;
    leftmousebutton,rightmousebutton:boolean;
    rightclickitem,leftclickitem:integer;
    areatrack:array of integer;
    extareatrack:array of integer;
    imgspec:array[0..235] of integer;
    loading_db:boolean;
    loading_dat:boolean;
    movie:boolean;
    fileroot,dbfile,datfile,kmfile:string;
    save_result:boolean;
    sumwav:wavefile;
    cdata:array of ncdata;
    dbpath:string;
    clustering:boolean;
    savebitmaps:boolean;
    Floatdat:boolean;
    loadingexternaldata:boolean;
    //
    prevsyltime,currentsyltime:double; //debugging variables
    //
    usedisk,usemem:boolean;
    //
    negativeintervalcounter:integer;
    //
    syl_wavdata:array of Integer;
    procedure writefixedfiles;
    procedure makegatehis;
    procedure makedurationhis;
    function RAvg(Sample:smallint):smallint;
    function  GetSpecialFolder( aFolder: Integer; var Location: String ): LongWord;
    procedure showwave;
    procedure StartHPfilter;
    procedure StartLPfilter;
    procedure StartHPfilterw;
    procedure StartLPfilterw;
    procedure filter;
    procedure LPfilter;
    procedure filter2;
    procedure chart;
    procedure chart2;
    procedure sonogram2;
    procedure count;
    procedure count2;
    procedure play;
    procedure SetZipFName( aCaption: String; AssignName: Boolean );
    procedure fillgrid;
    procedure getzipfile;
    function  envelope(sample:integer):integer;
    function  envelope2(sample:integer):integer;
    procedure showfilterkar;
    procedure spectrum(x,y:integer);
    procedure processfile;
    procedure ReadFiles;
    procedure ReadFilesAuto;
    procedure Getspectrum(Windowmode,Windowlength:integer;var Power:array of double);
    procedure GetspectrumI(Windowmode,Windowlength:integer;var Power:array of double);
    procedure CompareSpectra(x1,x2,y:integer;var R:double);
    procedure nsp_corr(datax,datay:array of double;points:integer;var corr:double);
    procedure showcorrgraph(points:integer;var p1,p2:array of double);
    procedure SpectrumCorrelationMap;
    procedure schannel_rightscroll_change(Sender: TObject);
    procedure schannel_leftscroll_change(Sender: TObject);
    procedure wchannel_rightscroll_change(Sender: TObject);
    procedure echannel_rightscroll_change(Sender: TObject);
    procedure echannel_leftscroll_change(Sender: TObject);
    procedure wchannel_leftscroll_change(Sender: TObject);
    procedure schannel_colors_click(Sender: TObject);
    procedure AhoSpectrum(Windowmode,Windowlength:integer;var Power:array of double);
    procedure aho_sonogram2;
    procedure showbmphis;
    procedure fitlist;
    procedure drawgatemarks;
    procedure info2spreadsheet;
    procedure addimage(name:string);
    procedure smallpreview;
    procedure printsummary(page:integer);
    procedure summarypreview(page:integer);
    procedure WriteEbuffer(number:integer;Nofsamples:integer);
    procedure ReadEbuffer(number:integer;Nofsamples:integer);
    procedure BPfilterini;
    procedure BPfiltersampledouble(var sample:double);
    //km down here
    procedure readimage(imagetime:integer);
    procedure readidb(imagetime:integer);
    function  calcspecdist(k,l:integer):extended;
    function  filename2datetime(filename:string):Tdatetime;
    function  filename2msecinday(filename:string):int64;
    procedure subcluster(cluster:integer);
    procedure readimagebyindex(index:integer);
    procedure memreadimagebyindex(index:integer);
    procedure readidbbyindex(index:integer);
    procedure memreadidbbyindex(index:integer);
    procedure readsmallimagebyindex(index:integer);
    procedure LPfilterSyllable(start,eind:Integer);
  end;

type Tprintpar=record
       mag:double;
       xoffset:double;
       yoffset:double;
end;

procedure ScreenShot(bm: TBitmap; Left, Top, Width, Height: Integer; Window: HWND); overload;
procedure QSort(var Y,X : array of integer;Ubound : Integer);
procedure QSortS(var Y,X : array of smallint;Ubound : Integer);
procedure QSortD(var Y,X : array of double;Ubound : Integer);
procedure MedFilter(var bmp1,bmp2:Tbitmap32;radius:integer);
procedure sharp_bmp(var inbmp:Tbitmap32);
procedure printscreen;


function PathWithoutRightElement_RFJ(name:string;element:string):string;
function winsor_average(data2:array of smallint;winsor:integer):double;
function winsor_averageF(data2:array of double;winsor:integer):double;

var
 Form1: TForm1;
 BPTaps:Integer;
 BPCoeff:array[0..999] of double;
 BP_Lo_freq:double;
 BP_Hi_freq:double;
 BPState:TNSPFirState;
 BPWindow: TNSP_WindowType;
 BPnormal:integer;
 BPswitch:boolean;
 BPchannelstate:array[1..1] of TNSPFirState;
 CriticalSection: TRTLCriticalSection;



implementation

uses cDataStructs, measure, measure2, Unit5, Unit6, Unit7, Unit8,
  Unit9, Unit10, Unit11, splashform, printpreview2,
  Unit14, Unit17, Unit20, Unit21, Unit22, Unit23,
  Unit24, Unit25, Unit26, Unit27, Unit28, Unit29, Unit18, Unit30, Unit31,
  Unit32, Unit4;

{$R *.dfm}

function winsor_average(data2:array of smallint;winsor:integer):double;
var  temp:array of smallint;
     lower,upper:integer;
     sum:int64;
     i:integer;
begin
   sum:=0; result:=0;
   setlength(temp,high(data2));
   qsorts(data2,temp,high(data2));
   lower:=round(winsor*high(data2)/100);
   upper:=round((100-winsor)*high(data2)/100);
   if (upper-lower+1)<>0 then
   begin
     for i:=lower to upper do sum:=sum+temp[i];
     result:=sum/(upper-lower+1);
   end;
end;

function winsor_averageF(data2:array of double;winsor:integer):double;
var  temp:array of double;
     lower,upper:integer;
     sum:extended;
     i:integer;
begin
   sum:=0; result:=0;
   setlength(temp,high(data2));
   qsortd(data2,temp,high(data2));
   lower:=round(winsor*high(data2)/100);
   upper:=round((100-winsor)*high(data2)/100);
   if (upper-lower+1)<>0 then
   begin
     for i:=lower to upper do sum:=sum+temp[i];
     result:=sum/(upper-lower+1);
   end;
end;

function PathWithoutRightElement_RFJ(name:string;element:string):string;
var L:integer;
    E:string;
    i:integer;
    T:string;
    P:integer;
begin
   L:=0;
   L:=length(name);
   E:=element;
   for i:=1 to L do
   begin
     T:=copy(name,i,1);
     if T=E then
     begin
       P:=i;
     end;
   end;
   result:=copy(name,0,P-1);
end;

procedure ScreenShot(bm: TBitmap; Left, Top, Width, Height: Integer; Window: HWND); overload;
var
  WinDC: HDC;
  Pal: TMaxLogPalette;
begin
  bm.Width := Width;
  bm.Height := Height;

  // Get the HDC of the window...
  WinDC := GetDC(Window);
  //if not WinDC = 0 then
  begin
   if (GetDeviceCaps(WinDC, RASTERCAPS) and RC_PALETTE) = RC_PALETTE then
   begin
    FillChar(Pal, SizeOf(TMaxLogPalette), #0);  // fill the structure with zeros
    Pal.palVersion := $300;                     // fill in the palette version

    // grab the system palette entries...
    Pal.palNumEntries := GetSystemPaletteEntries(WinDC, 0, 256, Pal.palPalEntry);
    if Pal.PalNumEntries <> 0 then
      bm.Palette := CreatePalette(PLogPalette(@Pal)^);
   end;
   // copy from the screen to our bitmap...
   BitBlt(bm.Canvas.Handle, 0, 0, Width, Height, WinDC, Left, Top, SRCCOPY);
  end;
  ReleaseDC(0, WinDC);        // finally, relase the DC of the window
end;

procedure QSort(var Y,X : array of integer;Ubound : Integer);
  { Quick sort in ascending order - Adapted from Borland's BP7 demo }
    procedure Sort(L, R : Integer);
    var
      I, J : Integer;
      U, V : Integer;
    begin
      I := L;
      J := R;
      U := X[(L + R) div 2];
      repeat
        while X[I] < U do I := I + 1;
        while U < X[J] do J := J - 1;
        if I <= J then
          begin
            V := X[I]; X[I] := X[J]; X[J] := V;
            I := I + 1; J := J - 1;
          end;
      until I > J;
      if L < J then Sort(L, J);
      if I < R then Sort(I, R);
    end;
var i,j:integer;
begin
  //Lbound:=0;
  for i:=0 to Ubound do  x[i]:=y[i];
  Sort(0,UBound);
end;

procedure QSortS(var Y,X : array of smallint;Ubound : Integer);
  { Quick sort in ascending order - Adapted from Borland's BP7 demo }
    procedure Sort(L, R : smallint);
    var
      I, J : smallint;
      U, V : smallint;
    begin
      I := L;
      J := R;
      U := X[(L + R) div 2];
      repeat
        while X[I] < U do I := I + 1;
        while U < X[J] do J := J - 1;
        if I <= J then
          begin
            V := X[I]; X[I] := X[J]; X[J] := V;
            I := I + 1; J := J - 1;
          end;
      until I > J;
      if L < J then Sort(L, J);
      if I < R then Sort(I, R);
    end;
var i,j:smallint;
begin
  //Lbound:=0;
  for i:=0 to Ubound do  x[i]:=y[i];
  Sort(0,UBound);
end;

procedure QSortD(var Y,X : array of double;Ubound : Integer);
  { Quick sort in ascending order - Adapted from Borland's BP7 demo }
    procedure Sort(L, R : integer);
    var
      I, J : integer;
      U, V : double;
    begin
      I := L;
      J := R;
      U := X[(L + R) div 2];
      repeat
        while X[I] < U do I := I + 1;
        while U < X[J] do J := J - 1;
        if I <= J then
          begin
            V := X[I]; X[I] := X[J]; X[J] := V;
            I := I + 1; J := J - 1;
          end;
      until I > J;
      if L < J then Sort(L, J);
      if I < R then Sort(I, R);
    end;
var i,j:integer;
begin
  //Lbound:=0;
  for i:=0 to Ubound do  x[i]:=y[i];
  Sort(0,UBound);
end;

procedure sharp_bmp(var inbmp:Tbitmap32);
var sbmp:Tbitmap;
begin
   sbmp:=Tbitmap.create;
   inbmp.assignto(sbmp);
   ConvolveFilter(6,0,sbmp);
   inbmp.assign(sbmp);

   sbmp.Dormant;
   sbmp.freeImage;
   sbmp.ReleaseHandle;
   sbmp.Free;
end;

procedure MedFilter(var bmp1,bmp2:Tbitmap32;radius:integer);
var x,y,i,k,l:integer;
    xs,ys,xe,ye:integer;
    med:integer;
    size,size2:integer;
    ltmdn:integer;
    hist:array[0..255] of integer;
    ar,sar:array[0..6561] of integer;
    Imageheight,imagewidth:integer;
    p:integer;
    gray:byte;
begin
  ImageHeight:=bmp1.Height;
  ImageWidth:=bmp1.width;

  size:=2*radius+1;
  size2:=size*size;

  for y:=0 to ImageHeight-1 do
   begin
    ltmdn:=0;
    for i:=0 to 255 do hist[i]:=0;
    for x:=0 to ImageWidth-1 do
     begin
      if x=0 then
       begin
        for k:=-radius to radius do
         for l:=-radius to radius do
          begin
           if (x+k>=0) and (x+k<=ImageWidth-1) and (y+l>=0) and (y+l<=ImageHeight-1) then
            ar[size*(radius+k)+(radius+l)]:=redcomponent(bmp1.Pixels[x+k,y+l])
           else ar[size*(radius+k)+(radius+l)]:=0;
           p:=ar[size*(radius+k)+(radius+l)];
           Inc(hist[p]);
          end;
        qsort(ar,sar,size2);
        med:=sar[size2 div 2];
        for i:=0 to med-1 do ltmdn:=ltmdn+hist[i];
       end
      else
       begin
        for l:=-radius to radius do
         begin
          Dec(hist[ar[size*((x-1) mod size)+radius+l]]);
          if ar[size*((x-1) mod size)+radius+l]<med then ltmdn:=ltmdn-1;

          if (x+radius<=ImageWidth-1) and (y+l>=0) and (y+l<=ImageHeight-1) then
           ar[size*((x-1) mod size)+radius+l]:=redcomponent(bmp1.Pixels[x+radius,y+l])
          else ar[size*((x-1) mod size)+radius+l]:=0;
          Inc(hist[ar[size*((x-1) mod size)+radius+l]]);
          if ar[size*((x-1) mod size)+radius+l]<med then Inc(ltmdn);
         end;
        if (ltmdn<=size2 div 2) then
         begin
          repeat
           ltmdn:=ltmdn+hist[med];
           Inc(med);
          until (ltmdn>size2 div 2) or (med=255);
          ltmdn:=ltmdn-hist[med-1];
          Dec(med);
         end
        else
         repeat
          ltmdn:=ltmdn-hist[med-1];
          Dec(med);
         until (ltmdn<=size2 div 2) or (med=0);
       end;
       BMP2.SetPixelT(x,y,color32(med,med,med));
     end;
   end;
end;

function check_extension(filename,extension:string):string;
begin
    if uppercase(extractfileExt(Filename))= uppercase(extension) then
      result:=filename
    else
      result:=filename+extension;
end;

procedure ApplyDataWindow(var signal : array of TFFTFloat);
  var
    wi : TFFTWindowInfo;
    Window:integer;
begin
  window:=form1.combobox6.itemindex+1;
  case window of
    1 : wi := ApplySumCosineWindow(signal, wCoeffHann);
    2 : wi := ApplySumCosineWindow(signal, wCoeffHamming);
    3 : wi := ApplySumCosineWindow(signal, wCoeffBlackman);
    4 : wi := ApplySumCosineWindow(signal, wCoeffNuttall);
    5 : wi := ApplySumCosineWindow(signal, wCoeffFlattop3);
    6 : wi := ApplySumCosineWindow(signal, wCoeffTaylor60);
    7 : wi := ApplySumCosineWindow(signal, wCoeffTaylor80);
    8 : wi := ApplyWindow(signal, WTriangle);
    9 : wi := ApplyWindow(signal, WWelch);
    else Exit;
  end;
  // Correct the amplitude effects of the window
  ScaleVector(signal, 1/wi.intw);
end;

procedure Tform1.showbmphis;
var i,x,y:integer;
    greyhis:array[0..255] of integer;
    hismax:integer;
    grey:byte;
    perc:integer;
    nofpixels:int64;
    freq2bin:double;
    lofreq,hifreq:integer;
    hissum:integer;
    testsum:integer;
begin
  freq2bin:=(rfjchart2.trace[schannel].ygmax-rfjchart2.trace[schannel].ygmin)/fbmp2.Height;
  lofreq:=fbmp2.height-round(rxspinedit35.value/freq2bin);
  hifreq:=fbmp2.height-round(rxspinedit36.value/freq2bin);

  rfjchart7.traces:=1;
  rfjchart7.trace[1].ygmin:=0;
  rfjchart7.trace[1].ygmax:=100;
  rfjchart7.backcolor:=clwhite;
  rfjchart7.trace[1].pen.color:=clblack;
  rfjchart7.trace[1].xaxispen.color:=clblack;
  rfjchart7.trace[1].yaxispen.color:=clblack;
  rfjchart7.trace[1].clipy:=true;
  rfjchart7.start:=0;
  rfjchart7.eind:=245;
  rfjchart7.trace[1].ymarginleft:=50;
  rfjchart7.trace[1].ymarginright:=10;
  rfjchart7.trace[1].yaxislegend:='';
  rfjchart7.setuptraces;
  rfjchart7.drawaxes;
  rfjchart7.reset;
  rfjchart7.buffered:=false;
  for i:=0 to 255 do
  begin
      greyhis[i]:=0;
  end;
  nofpixels:=0;
  for y:=hifreq to lofreq do
    for x:=0 to fbmp2.width-1 do
    begin
        inc(nofpixels);
        grey:=redcomponent(fbmp2.PixelS[x,y]);
        inc(greyhis[grey]);
    end;
  hismax:=0;
  hissum:=0;
  for i:=2 to 240 do
  begin
      hissum:=hissum+greyhis[i];
  end;
  testsum:=0;
  for i:=2 to 240 do
  begin
      if testsum<round(rxspinedit33.value*hissum/100) then
      begin
         testsum:=testsum+greyhis[i];
         perc:=i;
      end;
      if greyhis[i]>hismax then hismax:=greyhis[i]
  end;
  if checkbox21.checked then rxspinedit34.value:=perc;
  rfjchart7.traces:=1;
  rfjchart7.trace[1].ygmin:=0;
  rfjchart7.trace[1].ygmax:=hismax / 2;
  rfjchart7.backcolor:=clwhite;
  rfjchart7.trace[1].pen.color:=clblack;
  rfjchart7.trace[1].xaxispen.color:=clblack;
  rfjchart7.trace[1].yaxispen.color:=clblack;
  rfjchart7.trace[1].clipy:=true;
  rfjchart7.start:=0;
  rfjchart7.eind:=245;
  rfjchart7.trace[1].ymarginleft:=50;
  rfjchart7.trace[1].ymarginright:=10;
  rfjchart7.trace[1].yaxislegend:='';
  //rfjchart1.drawmode:=dmskyline;
  rfjchart7.setuptraces;
  rfjchart7.drawaxes;
  rfjchart7.reset;
  rfjchart7.buffered:=false;
  for i:=0 to 255 do
  begin
      rfjchart7.addpoint(1,i,greyhis[i]);
  end;
   rfjchart7.update;
end;

procedure TForm1.AhoSpectrum(Windowmode,Windowlength:integer;var Power:array of double);
var
    sig : array of Single;
    spec : array of TFFTComplex;
    amplitude : array of Single;
    max : Single;
    scale : Double;
    n,i : Integer;
begin
    //n:=trunc(rxspinedit37.Value);
    n:=windowlength;
    SetLength(sig, n);
    for i := 0 to n-1 do sig[i] := slice[i];
    ApplyDataWindow(sig);
    SetLength(spec, n);
    FFT(sig, spec);
    SetLength(amplitude, n);
    RectToAbs(spec, amplitude);
    SetLength(amplitude, n div 2 + 1);
    ScaleVector(amplitude, 2/n);
    amplitude[0] := amplitude[0] / 2;
    amplitude[n div 2] := amplitude[n div 2] / 2;
    for i:=0 to n div 2 do power[i]:=amplitude[i]*0.45;
    SetLength(sig, 0);
    SetLength(amplitude, 0);
end;


procedure Tform1.schannel_colors_click(Sender: TObject);
var i:integer;
    temp:smallint;
begin
    colors.ColorTable:=colors.ColorTable+1;
    if colors.ColorTable=11 then colors.ColorTable:=1;
    if colors.ColorTable=9 then
    begin
     colors.Minvalue:=0;
     colors.Maxvalue:=1024;
    end;
    //sonogram;
    //schannel_leftscroll_change(self);
end;

procedure Tform1.makegatehis;
var rephis:array [1..100] of smallint;
    rephisbinwidth:integer; // in msec;
    bin:integer;
    g1,g2:double;
    i:integer;
    hiswidth:integer;
    nofbins:integer;
    statdata:Tvector;
    pstatdata:Pvector;
    nofobservations:integer;
    hismedian:single;
begin
   //gate statistics
   //
   //histogram of repetition rate
   //intervals between the 0->90 gate times (column 0)
   rfjchart3.traces:=1;
   pstatdata:=@statdata;
   nofbins:=trunc(rxspinedit25.value);
   nofobservations:=0;
   dimvector(pstatdata,nofobservations);
   if nofbins>high(rephis) then nofbins:=high(rephis);
   rephisbinwidth:=trunc(rxspinedit26.value); //msec
   hiswidth:=nofbins*rephisbinwidth;
   for i:=1 to nofbins do
   begin
       rephis[i]:=0;
   end;
   for i:=0 to advstringgrid1.RowCount-1 do
   begin
       if (advstringgrid1.Cells[0,i]<>'') and (advstringgrid1.Cells[0,i+1]<>'') then
       begin
           g1:=strtofloat(advstringgrid1.Cells[0,i]);
           g2:=strtofloat(advstringgrid1.Cells[0,i+1]);
           bin:=1+trunc((g2-g1)/rephisbinwidth);
           if (bin>=low(rephis)) and (bin<=high(rephis)) then inc(rephis[bin]);
           inc(nofobservations);
           dimvector(pstatdata,nofobservations);
           statdata[nofobservations-1]:=(g2-g1);
       end;
   end;
   pstatdata:=@statdata;
   if nofobservations>1 then hismedian:=median((pstatdata),0,nofobservations-1);
   //autosize
   rfjchart3.trace[1].ygmax:=0;
   for i:=1 to nofbins do
   begin
       if rephis[i]>rfjchart3.trace[1].ygmax then rfjchart3.trace[1].ygmax:=1+ceil(rephis[i]*1.1);
   end;
   with rfjChart3 do
   begin
       backcolor:=clwhite;
       start:=0;
       eind:=hiswidth;
       if hismedian>hiswidth then RxSpinEdit25.value:=2*RxSpinEdit25.value;
       trace[1].ygmin:=0;
       if trace[1].ygmax=0 then trace[1].ygmax:=25;
       trace[1].clipy:=true;
       trace[1].ymarginleft:=40;
       trace[1].showtitle:=true;
       trace[1].graphtitle:='';
       trace[1].ftext[1].text:='Median='+  FloatToStrF(hismedian,ffgeneral,6,2);
       trace[1].ftext[1].xpos:=trace[1].yright-125;
       trace[1].ftext[1].ypos:=1;
       trace[1].ftext[1].font:=bmp.font;
       trace[1].yaxislegend:='';
       drawmode:=dmbar;
       setuptraces;
       drawtext;
       drawaxes;
       reset;
   end;
   for i:=1 to nofbins do
   begin
       rfjChart3.addpoint(1,(i*rephisbinwidth),rephis[i]);
   end;
   rfjchart3.setxmark(1,hismedian);
   rfjchart3.update;
   dimvector(pstatdata,0); //rfj 2006 15-12
end;

procedure Tform1.makedurationhis;
var durhis:array [1..100] of smallint;
    durhisbinwidth:integer; // in msec;
    bin:integer;
    g1,g2:double;
    i:integer;
    hiswidth:integer;
    nofbins:integer;
    statdata:Tvector;
    pstatdata:Pvector;
    nofobservations:integer;
    hismedian:single;
begin
   //gate statistics
   //
   //histogram of duration rate
   //intervals between the 0->90 gate times (column 0)
   rfjchart6.traces:=1;
   pstatdata:=@statdata;
   nofbins:=trunc(rxspinedit27.value);
   nofobservations:=0;
   dimvector(pstatdata,nofobservations);
   if nofbins>high(durhis) then nofbins:=high(durhis);
   durhisbinwidth:=trunc(rxspinedit28.value); //msec
   hiswidth:=nofbins*durhisbinwidth;
   for i:=1 to nofbins do
   begin
       durhis[i]:=0;
   end;
   for i:=0 to advstringgrid1.RowCount-1 do
   begin
       if (advstringgrid1.Cells[2,i]<>'') then
       begin
           g1:=strtofloat(advstringgrid1.Cells[2,i]);
           bin:=1+trunc((g1)/durhisbinwidth);
           if (bin>=low(durhis)) and (bin<=high(durhis)) then inc(durhis[bin]);
           inc(nofobservations);
           dimvector(pstatdata,nofobservations);
           statdata[nofobservations-1]:=g1;
       end;
   end;
   pstatdata:=@statdata;
   if nofobservations>1 then hismedian:=median((pstatdata),0,nofobservations-1);
   //autosize
   rfjchart6.trace[1].ygmax:=0;
   for i:=1 to nofbins do
   begin
       if durhis[i]>rfjchart6.trace[1].ygmax then rfjchart6.trace[1].ygmax:=1+ceil(durhis[i]*1.1);
   end;
   with rfjChart6 do
   begin
       backcolor:=clwhite;
       start:=0;
       eind:=hiswidth;
       if hismedian>hiswidth then RxSpinEdit27.value:=2*RxSpinEdit27.value;
       trace[1].ygmin:=0;
       if trace[1].ygmax=0 then trace[1].ygmax:=25;
       trace[1].clipy:=true;
       trace[1].ymarginleft:=40;
       trace[1].showtitle:=true;
       trace[1].graphtitle:='';
       trace[1].ftext[1].text:='Median='+  FloatToStrF(hismedian,ffgeneral,6,2);
       trace[1].ftext[1].xpos:=trace[1].yright-125;
       trace[1].ftext[1].ypos:=1;
       trace[1].ftext[1].font:=bmp.font;
       trace[1].yaxislegend:='';
       drawmode:=dmbar;
       setuptraces;
       drawtext;
       drawaxes;
       reset;
   end;
   for i:=1 to nofbins do
   begin
       rfjChart6.addpoint(1,(i*durhisbinwidth),durhis[i]);
   end;
   rfjchart6.setxmark(1,hismedian);
   rfjchart6.update;

   dimvector(pstatdata,0);  //rfj 2006 15-12
end;

procedure Tform1.echannel_leftscroll_change(Sender: TObject);
var memsize:integer;
    testhi,testlo:extended;
    gridrow:integer;
    i:integer;
    prevgatelevel,gatelevel:integer;
    prevgateswitch,gateswitch:integer;
    gateinterval,gatetime:double;
    gdata:array of smallint;
    testgate:integer;
    testgatelevel:integer;
    fastnoise:boolean;
    j:integer;
    t1,t2,freq:int64;
    elapsed:integer;
    sono2time:double;
    testlevel:integer;
    darkcount,testcountlevel:integer;
    gatecol:integer;
    wenthigh:integer;
    hasbeenhigh:boolean;
    lotime,hitime:integer;
    realstart:integer;
    currenttime:double;
    realgatelevel:integer;
    t:TTimestamp;
    tiffname:string;
    midgate:double;
    cdir,selectionpath,selectionpath2,dst:string;
    write_error:boolean;
    dstrect,srcrect:Trect;
    rectstring:string;
    bwritten:integer;
    pixelval:byte;
    pixelvalarray:array of byte;
    x,y:integer;
    syltime:integer;
    w,h:smallint;
    int1,int2:integer;
    notgateinterval:double;
    g1,g2:double;
    gridrow2:integer;
    rrstep:integer;
    pixelpointer:integer;
    tempval:int64;
begin
   //form21.show;
   //form21.advspreadgrid1.Clear;
   //form21.advspreadgrid1.RowCount:=0;

   if form22.CheckBox1.Checked or form22.CheckBox2.Checked then
   begin
     form22.advspreadgrid1.Hide;
     form22.advspreadgrid1.Clear;
     form22.advspreadgrid1.RowCount:=0;
     rrstep:=trunc(form22.rxspinedit1.value);
     form22.Update;
   end;

   for i:=0 to advstringgrid1.RowCount do
   begin
       advstringgrid1.cells[0,i]:='';
       advstringgrid1.cells[1,i]:='';
       advstringgrid1.cells[2,i]:='';
   end;
   if checkbox54.Checked then
       showmessage('It is not a good idea to measure with the SMART DISPLAY option switched on!');

   statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
   if checkbox28.Checked then rxgifanimator4.show;
   //
   {
   if not processing then
   BEGIN
    Try
      //mynewfilename := savedialog1.FileName;
      mynewfilename := 'c:\temp\soundimages.db';
      FFile := TFileStream.Create(mynewfilename,fmCreate);
    finally
    end;
   END;
   }
   //
   advstringgrid1.beginupdate;
   advstringgrid1.rowcount:=1;
   advstringgrid1.clear;
   gridrow:=-1;
   gridrow2:=-1;
   xoffset:=0;
   if advspreadgrid1.Cells[4,currentrow]<>'' then
   begin
        T:=DateTimeToTimeStamp(strtofloat(advspreadgrid1.Cells[4,currentrow]));
        xoffset:=T.Time;
        xoffset:=round(strtofloat(advspreadgrid1.Cells[6,currentrow]));  //rjrjrj
   end;
   if checkbox53.Checked then xoffset:=0;

   if checkbox52.checked then
   begin
     info2spreadsheet;
     gridrow:=0;
     gridrow2:=0;
   end;
   clip32:=Tbitmap32.create;
   clip:=Tbitmap.Create;
   clip.pixelformat:=pf32bit;
   hasbeenhigh:=false;
   queryperformancecounter(T1);
   if checkbox28.Checked then rxgifanimator4.show;
   if checkbox29.Checked then
   begin
    statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
    memo1.Lines.Add(' echannel_leftscroll_change '+DateTimeToStr(Now));
   end;

   testhi:=(slide[echannel].max-slide[echannel].Position);
   testlo:=(slide[echannel].max-slide[echannel].Position-rxspinedit22.value);
   rxspinedit76.value:=testhi;
   with rfjchart2 do
   begin
     erasetrace(echannel);
     trace[echannel].clipy:=true;
     trace[echannel].drawygzero:=false;
     trace[echannel].graphtitle:='Gate Levels='+inttostr(trunc(testhi))+' ,'+inttostr(trunc(testlo));
     trace[echannel].ygmax:=slide2[echannel].Position;
     trace[echannel].ygmin:=0;
     if (trace[echannel].ygmax-trace[echannel].ygmin)>0 then
                            trace[echannel].vertscale:=((trace[echannel].xbottom-trace[echannel].xtop)/(trace[echannel].ygmax-trace[echannel].ygmin));
     eraseyleft(echannel);
     eraseyright(echannel);
     drawallaxes(echannel);
     reset;
     drawbuffer(echannel);
     setymark(echannel,(slide[echannel].max-slide[echannel].Position));
     setymark(echannel,(slide[echannel].max-slide[echannel].Position-trunc(rxspinedit22.value)));
   end;
   slideposition[5]:=slide[echannel].Position;
   with rfjchart2 do
   begin
     erasetrace(gchannel);
     trace[gchannel].buffersize:=0;
     drawallaxes;
     reset;
   end;

   //GATE
   if checkbox16.Checked then
   begin
    //form10.Show;
    slide[echannel].show;
    rfjchart2.drawmode:=dmline;
    rfjchart2.reset;
    testhi:=(slide[echannel].max-slide[echannel].Position);
    testlo:=(slide[echannel].max-slide[echannel].Position-rxspinedit22.value);
    //advstringgrid1.Clear;
    gridrow:=-1;

    xoffset:=0;
    if advspreadgrid1.Cells[4,currentrow]<>'' then
      begin
        T:=DateTimeToTimeStamp(strtofloat(advspreadgrid1.Cells[4,currentrow]));
        xoffset:=T.Time;
        xoffset:=round(strtofloat(advspreadgrid1.Cells[6,currentrow]));  //rjrjrj
    end;
    if checkbox53.Checked then xoffset:=0;

    if checkbox52.checked then
    begin
     info2spreadsheet;
     gridrow:=0;
     gridrow2:=0;
    end;
    if (ebuffer[startsample]>testhi) then prevgatelevel:=90 ;
    if (ebuffer[startsample]<testlo) then prevgatelevel:=0;
    hitime:=trunc(rate*rxspinedit24.value/1000);
    lotime:=trunc(rate*rxspinedit6.value/1000);

    //ravg-envelope en fir-envelope en sonogram envelope
    if checkbox11.Checked or checkbox13.Checked or checkbox46.Checked then
    begin
      //for i:=startsample to eindsample-1 do
      //begin
      i:=startsample;
      realstart:=startsample;
      fastnoise:=false;
      while (i<eindsample-1) do
      begin
        if (i>low(ebuffer)) and (i<high(ebuffer)) then
        begin
          if realstart>i then
          begin
             i:=realstart;
             //prevgatelevel:=realgatelevel;
          end;
          if (ebuffer[i]>testhi) then gatelevel:=90 ;
          if (ebuffer[i]<testlo) then gatelevel:=0;
          if prevgatelevel=gatelevel then
          begin
            tempval:=i;gatetime:=(1000*tempval)/rate;
            rfjchart2.addpoint(gchannel,gatetime,gatelevel);
          end;
          if prevgatelevel<>gatelevel then
          begin
             //transition?
             fastnoise:=false;
             if gatelevel=90 then testgate:=hitime;
             if gatelevel=0 then testgate:=lotime;
             for j:=i to (i+testgate) do
             begin
                  if (ebuffer[j]>testhi) then testgatelevel:=90 ;
                  if (ebuffer[j]<testlo) then testgatelevel:=0;
                  if testgatelevel<>gatelevel then
                  begin
                     fastnoise:=true;
                     realstart:=j;
                     //realgatelevel:=testgatelevel;
                     break;
                  end;
             end;
             if fastnoise then gatelevel:=prevgatelevel;
             if not fastnoise then
             begin
               prevgateswitch:=gateswitch;
               gateswitch:=i;
               tempval:=i;
               gatetime:=1000*tempval/rate;
               if gatelevel=90 then
               begin
                   inc(gridrow);
                   if gridrow>(advstringgrid1.RowCount-1) then
                   begin
                       advstringgrid1.RowCount:=advstringgrid1.RowCount+1;
                   end;
                   advstringgrid1.Cells[0,gridrow]:=(floattostrf(xoffset+gatetime,fffixed,12,2));
                   if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
                   //
                   gatecol:=ceil(((gatetime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);
                   hasbeenhigh:=true;
                   wenthigh:=gatecol;
                   //
                   //only if we want to measure silent intervals as well  for rr-plot
                   if (gridrow>0) and form22.checkbox2.checked then
                   begin
                      inc(gridrow2);
                      g1:=strtofloat(advstringgrid1.Cells[1,gridrow-1]);
                      g2:=strtofloat(advstringgrid1.Cells[0,gridrow]);
                      notgateinterval:=g2-g1;
                      form22.advspreadgrid1.RowCount:=gridrow2;
                      form22.advspreadgrid1.Cells[1,gridrow2]:=inttostr(gridrow2+1);
                      form22.advspreadgrid1.Cells[2,gridrow2]:=(floattostrf(notgateinterval,fffixed,6,2));
                      form22.advspreadgrid1.RowColor[gridrow2]:=clteal;
                    end;
                   //
               end;
               if gatelevel=0 then
               begin
                    gateinterval:=1000*((gateswitch-prevgateswitch)/rate);

                    xoffset:=0;
                    if advspreadgrid1.Cells[4,currentrow]<>'' then
                    begin
                        T:=DateTimeToTimeStamp(strtofloat(advspreadgrid1.Cells[4,currentrow]));
                        xoffset:=T.Time;
                        xoffset:=round(strtofloat(advspreadgrid1.Cells[6,currentrow]));  //rjrjrj                        
                    end;
                    if checkbox53.Checked then xoffset:=0;

                    midgate:=xoffset+gatetime-(gateinterval/2);
                    form3.Label2.caption:=floattostr(midgate);
                    //spectrum(1,1);
                    //advstringgrid1.Cells[7,gridrow]:=label78.caption;
                    //advstringgrid1.Cells[8,gridrow]:=label79.caption;


                    if gridrow<0 then
                    begin
                      gridrow:=0;
                      gateinterval:=0;
                    end;
                    advstringgrid1.Cells[1,gridrow]:=(floattostrf(xoffset+gatetime,fffixed,12,2));
                    advstringgrid1.Cells[2,gridrow]:=(floattostrf(gateinterval,fffixed,6,2));


                    //sound intervals for rr-plot
                    if (gridrow>=0) and form22.checkbox1.checked then
                    begin
                               inc(gridrow2);
                               form22.advspreadgrid1.RowCount:=gridrow2;
                               form22.advspreadgrid1.Cells[1,gridrow2]:=inttostr(gridrow2+1);
                               form22.advspreadgrid1.Cells[2,gridrow2]:=(floattostrf(gateinterval,fffixed,6,2));
                    end;
                    //

                    if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
                    //
                    gatecol:=trunc(((gatetime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);

                    if hasbeenhigh and save_db then
                    begin
                     FStream := TMemoryStream.Create;
                     clip32.Width:=gatecol-wenthigh;
                     clip32.height:=fbmp2.Height;
                     fbmp2.DrawTo(clip32,
                                 rect(0,0,clip32.width,clip32.Height),
                                 rect(wenthigh-2,0,gatecol+2,fbmp2.height));

                     //clip32.SaveToClipboard;
                     png.CompressionLevel:=9;
                     png.Filters:=[pfNone, pfSub, pfUp, pfAverage, pfPaeth];
                     clip32.AssignTo(clip);

                     tiffname:=currentfile+'_'+advstringgrid1.Cells[1,gridrow]+'.tiff';
                     WriteTiffToFile(tiffname,clip);
                     tiffname:=''+advstringgrid1.Cells[1,gridrow]+'.tiff';
                     WriteTiffToFile(tiffname,clip);

                     PNG.assign(clip);
                     png.SaveToStream(FStream);
                     FStream.seek(0,0);
                     FHead.Magic := 1234567; //constant value
                     FHead.BitmapSize := FStream.size;
                     FHead.edit1string := currentfile;
                     FHead.edit2string := floattostr(gatetime);
                     FHead.edit3string := 'dummytext';
                     FFile.Write(FHead,SizeOf(TMyRecord));
                     FFile.CopyFrom(FStream,FStream.size );
                     fstream.free;
                    end;
                    //
                    if hasbeenhigh and save_bin and (advstringgrid1.Cells[0,gridrow]<>'') and (gridrow>=0) then
                    begin
                     clip32.Width:=gatecol-wenthigh;
                     clip32.height:=fbmp2.Height;
                     clip32.Clear(clwhite32);
                     dstrect:=rect(0,0,clip32.width,clip32.Height);
                     srcrect:=rect(wenthigh-2,0,gatecol+2,fbmp2.height);
                     if (srcrect.left>=0) and (srcrect.right<=fbmp2.width) and (srcrect.top>=0) and (srcrect.bottom<=fbmp2.height) then
                     begin
                               fbmp2.DrawTo(clip32,dstrect,srcrect);
                               clip32.AssignTo(clip);
                     end;
                     currentsyltime:=strtofloat(advstringgrid1.Cells[0,gridrow]);
                     syltime:=round(strtofloat(advstringgrid1.Cells[0,gridrow]));
                     if checkbox99.Checked then clip32.SaveToFile(advstringgrid1.Cells[0,gridrow]+'.bmp');
                     w:=clip32.width;
                     h:=clip32.height;
                     blockwrite(idb,syltime,4,bwritten);
                     blockwrite(idb,w,2,bwritten);
                     blockwrite(idb,h,2,bwritten);
                     setlength(pixelvalarray, w*h);
                     //setlength(cdata,w);
                     pixelpointer:=0;
                     for x:=0 to clip32.Width-1 do
                     begin
                      for y:=0 to clip32.height-1 do
                      begin
                          inc(pixelpointer);
                          if pixelpointer<(w*h) then pixelvalarray[pixelpointer]:=redcomponent(clip32.Pixel[x,y]);
                      end;
                     end;
                     blockwrite(idb,pixelvalarray[0],(w*h),bwritten);
                     inc(idb_written); label87.caption:=inttostr(idb_written);

                     //form21.advspreadgrid1.RowCount:=form21.advspreadgrid1.RowCount+1;
                     //form21.advspreadgrid1.cells[0,form21.advspreadgrid1.rowcount-1]:=inttostr(idb_written);
                     //form21.advspreadgrid1.cells[1,form21.advspreadgrid1.rowcount-1]:=inttostr(syltime);

                     my:=rfjchart2.trace[schannel].xtop+((rfjchart2.trace[schannel].xbottom-rfjchart2.trace[schannel].xtop) div 2);
                     mx:=rfjchart2.val2xpos(midgate-xoffset);


                     spectrum(mx,my);

                     if (currentsyltime-prevsyltime)<0 then
                     begin
                      //form1.caption:=floattostr(currentsyltime);form1.Update;
                      inc(negativeintervalcounter);
                     end;
                     prevsyltime:=currentsyltime;
                     //if (idb_written<> 100) then spectrum(mx,my); //force error for testing
                     //if advstringgrid1.Cells[0,gridrow]<>'' then
                     {
                     begin
                          cdir:=getcurrentdir;
                          selectionpath:=filepath+'\'+'images\';
                          selectionpath2:=ziphome+'\'+'images'+'_'+zipname+'\';
                          write_error:=false;

                          if not zip then
                          begin
                           if not DirectoryExists(selectionpath) then
                            if not CreateDir(selectionpath) then
                             if not checkbox63.checked then raise Exception.Create('Cannot create '+selectionpath);
                             tiffname:=inttostr(round(strtofloat(advstringgrid1.Cells[0,gridrow])));
                             dst:=selectionpath+tiffname+'.tiff';
                             WriteTiffToFile(dst,clip);
                          end;

                          if Zip then
                          begin
                           if not DirectoryExists(selectionpath2) then
                            if not CreateDir(selectionpath2) then
                              if not checkbox63.checked then raise Exception.Create('Cannot create '+selectionpath2);
                              tiffname:=inttostr(round(strtofloat(advstringgrid1.Cells[0,gridrow])));
                              dst:=selectionpath2+tiffname+'.tiff';
                              WriteTiffToFile(dst,clip);
                          end;
                          setcurrentdir(cdir);
                     end;
                     }
                   end;
               end;
               tempval:=i;gatetime:=(1000*tempval)/rate;
               rfjchart2.addpoint(gchannel,gatetime,gatelevel);
               prevgatelevel:=gatelevel;
             end;
          end;
        end;
        inc(i);
      end;
    end;
    //
    if pagecontrol2.ActivePage=pagecontrol2.Pages[0] then makegatehis;
    if pagecontrol2.ActivePage=pagecontrol2.Pages[1] then makedurationhis;
   end;
   ///

   if checkbox36.checked then
   begin
       rfjchart2.setymark(schannel,trunc(rxspinedit35.value),clred32);
       rfjchart2.setymark(schannel,trunc(rxspinedit36.value),clred32);
   end;


   rfjchart2.update;
   gridrows:=gridrow;
   if pagecontrol2.ActivePage=pagecontrol2.Pages[0] then makegatehis;
   if pagecontrol2.ActivePage=pagecontrol2.Pages[1] then makedurationhis;

   if checkbox29.Checked then
   begin
     queryperformancecounter(T2);
     queryperformancefrequency(freq);
     elapsed:=round((rate/(eindsample-startsample))*1000*(t2-T1)/freq);
     memo1.Lines.Add(inttostr(elapsed)+' echannel_leftscroll_change '+DateTimeToStr(Now));
   end;
   statusbar1.Panels[4].Text:='';statusbar1.Update;
   rxgifanimator4.hide;
   clip32.free;
   clip.Free;
   if not processing then ffile.free;
   advstringgrid1.endupdate;
   //
  if checkbox36.Checked then
   with form22 do
   begin
        for i:=0 to advspreadgrid1.RowCount-1 do
        begin
          if AdvSpreadGrid1.Cells[2,i]='' then
          begin
           AdvSpreadGrid1.RemoveRows(i,1);
          end;
       end;

       advspreadgrid1.SortSettings.Column:=2;
       advspreadgrid1.QSort;
       for i:=0 to advspreadgrid1.RowCount-1 do
       begin
          AdvSpreadGrid1.Cells[3,i]:=inttostr(i+1);
       end;
       advspreadgrid1.SortSettings.Column:=1;
       advspreadgrid1.QSort;
       advspreadgrid1.Show;
      {
       rfjchart1.traces:=1;
       rfjchart1.start:=0;
       rfjchart1.trace[1].graphtitle:= opendialog1.FileName;
       rfjchart1.trace[1].showtitle:=true;
       rfjchart1.eind:=advspreadgrid1.RowCount;
       rfjchart1.trace[1].ygmin:=0;
       rfjchart1.trace[1].ygmax:=advspreadgrid1.RowCount;
       rfjchart1.drawmode:=dmpoint;
       rfjchart1.trace[1].yaxislegend:='';
       rfjchart1.setuptraces;
       rfjchart1.drawaxes;
       for i:=0 to form22.advspreadgrid1.RowCount-2 do
       begin
          int1:=strtoint(AdvSpreadGrid1.Cells[3,i]);
          int2:=strtoint(AdvSpreadGrid1.Cells[3,i+1]);
          rfjchart1.addpoint(1,int1,int2);
       end;
       rfjchart1.update;
       }
   end;
   //
   FFile.Free;
   statusbar1.Panels[4].Text:='';statusbar1.Update;
   if checkbox28.Checked then rxgifanimator4.hide;

end;

procedure Tform1.wchannel_leftscroll_change(Sender: TObject);
var memsize:integer;
begin
   slideposition[1]:=slide[wchannel].Position;
   rfjchart2.keepdata:=true;
   rfjchart2.setuptraces;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.setymark(wchannel,slide[wchannel].Position);
   rfjchart2.setymark(wchannel,-slide[wchannel].Position);
   rfjchart2.update;
   count;
   if checkbox46.Checked then
   begin
         env_calc:=false;
         chart2;
         rfjchart2.setymark(wchannel,slide[wchannel].Position);
         rfjchart2.setymark(wchannel,-slide[wchannel].Position);
         rfjchart2.update;
   end;
   if checkbox49.Checked then drawgatemarks;
end;

procedure Tform1.echannel_rightscroll_change(Sender: TObject);
var memsize:integer;
    oldlevel:integer;
    t1,t2,freq:int64;
    elapsed:integer;
begin
   queryperformancecounter(T1);
   if checkbox28.Checked then rxgifanimator4.show;
   if checkbox29.Checked then
   begin
     statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
     memo1.Lines.Add(' echannel_rightscroll_change '+DateTimeToStr(Now));
   end;

   slideposition[6]:=slide2[echannel].Position;
   if checkbox16.Checked then
   begin
     oldlevel:=slide[echannel].max-slide[echannel].position;
     slide[echannel].Max:=slideposition[6];
     slide[echannel].LargeChange:=(slide[echannel].Max-slide[echannel].min) div 50 ;
     slide[echannel].SmallChange:=(slide[echannel].Max-slide[echannel].min) div 50 ;
     slide[echannel].position:=slide[echannel].max-oldlevel;
   end;
   with rfjchart2 do
   begin
     erasetrace(echannel);
     trace[echannel].ygmax:=slide2[echannel].Position;
     trace[echannel].ygmin:=0;
     if (trace[echannel].ygmax-trace[echannel].ygmin)>0 then
           trace[echannel].vertscale:=((trace[echannel].xbottom-trace[echannel].xtop)/(trace[echannel].ygmax-trace[echannel].ygmin));
     eraseyleft(echannel);
     eraseyright(echannel);
     drawallaxes;
     drawmode:=dmline;
     drawbuffer(echannel);
     drawmode:=dmpoint;
     if checkbox16.checked then
     begin
       setymark(echannel,(slide[echannel].max-slide[echannel].Position));
       setymark(echannel,(slide[echannel].max-slide[echannel].Position-trunc(rxspinedit22.value)));
     end;
     drawgatemarks;
     update;
   end;
   //application.ProcessMessages;
   if checkbox16.Checked then echannel_leftscroll_change(self);
   if checkbox29.Checked then
   begin
     queryperformancecounter(T2);
     queryperformancefrequency(freq);
     elapsed:=round((rate/(eindsample-startsample))*1000*(t2-T1)/freq);
     memo1.Lines.Add(inttostr(elapsed)+' echannel_rightscroll_change '+DateTimeToStr(Now));
   end;
   statusbar1.Panels[4].Text:='';statusbar1.Update;
   rxgifanimator4.hide;
end;

procedure Tform1.schannel_rightscroll_change(Sender: TObject);
var m:tmouse;
    yleft,yright,xtop,xbottom:integer;
    x,y:integer;
    pixelvalue:double;
    oldpower,newpower:integer;
    testgrey:byte;
    fftcolor:cardinal;
    t1,t2,freq:int64;
    elapsed:integer;
    oldcolor:byte;
    old2new:double;
begin
   //form8.LUTControl1Change(self);

   queryperformancecounter(t1);
   recalcsonogram:=true;
   if not (m.isdragging) then
    with rfjchart2 do
    begin
      if checkbox46.Checked then
       begin
         env_calc:=false;
         chart2;
       end
      else
       begin
        if checkbox47.Checked then aho_sonogram2 else sonogram2;
        trace[schannel].imagefilter:=combobox8.itemindex+1;
        trace[schannel].background:=fbmp2;
        erasetrace(schannel);
        drawallaxes;
        drawbuffer(schannel);
        update;
       end;

    end;
   if checkbox49.Checked then drawgatemarks;
   if checkbox29.Checked then
   begin
     queryperformancecounter(T2);
     queryperformancefrequency(freq);
     elapsed:=round((rate/(eindsample-startsample))*1000*(t2-T1)/freq);
     memo1.Lines.Add(inttostr(elapsed)+' schannel_rightscroll_change '+DateTimeToStr(Now));
   end;

end;

procedure Tform1.schannel_leftscroll_change(Sender: TObject);
var m:tmouse;
    x,y:integer;
    freq2bin:double;
    lofreq,hifreq:integer;
begin
 if not (m.isdragging) then
 begin
   freq2bin:=(rfjchart2.trace[schannel].ygmax-rfjchart2.trace[schannel].ygmin)/fbmp2.Height;
   lofreq:=fbmp2.height-round(rxspinedit35.value/freq2bin);
   hifreq:=fbmp2.height-round(rxspinedit36.value/freq2bin);
   slideposition[3]:=slide[schannel].Position;
   if not (m.isdragging) then if checkbox47.Checked then aho_sonogram2 else sonogram2;
   for y:=hifreq to lofreq do
    for x:=0 to Fbmp2.width-1 do
      if redcomponent(fbmp2.pixels[x,y])>(slide[schannel].Position) then
         fbmp2.setpixelt(x,y,clwhite32)
      else
         fbmp2.setpixelt(x,y,clblack32);

   rfjchart2.trace[schannel].imagefilter:=1+combobox8.ItemIndex;
   rfjchart2.erasetrace(schannel);
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.drawallaxes;
   rfjchart2.drawbuffer(schannel);
   rfjchart2.update;
   if checkbox46.Checked then
    begin
         env_calc:=false;
         chart2;
   end
 end;
end;


procedure Tform1.wchannel_rightscroll_change(Sender: TObject);
var memsize:integer;
begin
   slideposition[2]:=slide2[wchannel].Position;
   with rfjchart2 do
   begin
     drawmode:=dmline;
     erasetrace(wchannel);
     trace[wchannel].ygmax:=slide2[wchannel].Position;
     trace[wchannel].ygmin:=-slide2[wchannel].Position;
     trace[wchannel].vertscale:=((trace[wchannel].xbottom-trace[wchannel].xtop)/(trace[wchannel].ygmax-trace[wchannel].ygmin));
     eraseyleft(wchannel);
     eraseyright(wchannel);
     drawallaxes;
     drawbuffer(wchannel);
     update;
   end;
   if checkbox49.Checked then drawgatemarks;
end;

procedure printbitmap(Canvas:Tcanvas;Destrect:Trect;Bitmap:Tbitmap);
var Bitmapheader:Pbitmapinfo;
    BitmapImage:Pointer;
    HeaderSize:Dword;
    ImageSize:Dword;
begin
    GetDIBsizes(bitmap.handle,headersize,imagesize);
    getmem(bitmapheader,headersize);
    getmem(bitmapimage,imagesize);
    try
      getdib(bitmap.handle,bitmap.palette,bitmapheader^,bitmapimage^);
      stretchdibits(Canvas.Handle,
                    destrect.Left,destrect.Top,
                    destrect.Right-destrect.left,destrect.Bottom-destrect.Top,
                    0,0,
                    bitmap.width,bitmap.height,
                    bitmapimage,
                    Tbitmapinfo(Bitmapheader^),DIB_RGB_COLORS,SRCCOPY);
    finally
      Freemem(bitmapheader);
      Freemem(BitmapImage);
    end;
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
var width:extended;
begin
  width:=(rate div 2)/strtoint(combobox1.Items.strings[combobox1.ItemIndex]);
  label9.caption:=floattostrf(width,fffixed,6,2);
end;


function Tform1.envelope(sample:integer):integer;
var i:integer;
begin
      runningavg:=(((runningavgcount-1)*runningavg)+abs(sample))/runningavgcount;
      result:=trunc(runningavg);
end;

function Tform1.envelope2(sample:integer):integer;
var testsample,temp:double;
begin
      testsample:=abs(sample);
      temp:=round(nspdFir(LPchannelState[1],testsample));
      result:=round(temp);
end;

procedure Tform1.chart;
begin
    if pagecontrol1.ActivePage=Tabsheet2 then chart2;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var  i:integer;
begin
       //if (numfiles=0) then
       //chart2;
       //count2;
end;


procedure Tform1.showwave;
var i,j:integer;
    startwindow,startx,eindx:double;
    samplesread:integer;
    minutes,seconds:extended;
    firstsample:smallint;
    countsec:integer;
    prevfirstsample:integer;
    prevname:string;
    testdif:integer;
    dif,maxdif,error:integer;
    s1,s2,s3,s4:integer;
    clip:wavefile;
    result:boolean;
    written:integer;
    //s1,s2:smallint;
    temp:double;
    left,right:smallint;
    woffset:integer;
    sample:int64;
    amplify:integer;
begin
 //if not form1.Regware41.expired then
 begin
       zeromemory(@meanpower,4096*sizeof(double));
       form3.xoffset[1]:=0;
       form3.xoffset[2]:=0;
       form3.xoffset[3]:=0;
       form3.xoffset[4]:=0;
       if checkbox26.Checked then
       begin
         startx:=rxspinedit12.value;
         eindx:=rxspinedit13.value;
         startwindow:=eindx-startx;
       end;
       memo1.Lines.Add('showwave '+DateTimeToStr(Now));

       abovelevel:=0;
       wav_in:=wavefile.create;

       succes:=false;
       If not FileExists(opendialog1.filename) then
         ShowMessage('FILE NOT FOUND ('+opendialog1.filename+')')
       else
         wav_in.OpenForRead(opendialog1.filename,succes);

       if not succes then showmessage('error reading file ');

       if succes then
       begin
           statusbar1.Panels[5].Text:= opendialog1.filename;
           NofSamples:=wav_in.numsamples;
           Nofchannels:=wav_in.NumChannels;
           if nofchannels=2 then radiogroup5.Enabled:=true else radiogroup5.Enabled:=false;
           Bitspersample:=wav_in.BitsPerSample;
           rate:=wav_in.SamplingRate;
           statusbar1.Panels[3].Text:=inttostr(rate)+' Hz';
           seconds:=Nofsamples/rate;
           minutes:=seconds/60;
           slen3:=1000*seconds;  //milliseconds
           startsample:=0;
           Eindsample:=Nofsamples;
           //samplesperbin:=rxspinedit4.value*(rate/1000); // needed for sonogram alignment;
           samplesperbin:=strtoint(combobox1.Items.strings[combobox1.ItemIndex]);
           //SamplesPerResBin:=rxspinedit4.value*(rate/1000);

           rxspinedit12.MinValue:=0;
           rxspinedit12.Maxvalue:=slen3-0.1;

           if checkbox26.Checked then
             begin
               if eindx>rxspinedit13.MaxValue then
                begin
                 //rxspinedit13.MaxValue:=eindx;
                 rxspinedit13.Value:=eindx;
                end
               else rxspinedit13.value:=eindx;
              if startx>rxspinedit12.MaxValue then
                begin
                 //rxspinedit12.MaxValue:=eindx-startwindow;
                 rxspinedit12.Value:=eindx-startwindow;
                end
              else rxspinedit12.value:=startx;
             end
           else
             begin
               rxspinedit12.value:=0;
               rxspinedit13.value:=slen3;
             end;

           Eindsample:=trunc(rxspinedit13.value*rate/1000);
           Startsample:=trunc(rxspinedit12.value*rate/1000);

           if nofchannels=1 then
           begin
             setlength(wavdata,Nofsamples);
             wav_in.ReadSampleData(Nofsamples,samplesRead,wavdata);
           end;
           if nofchannels=2 then
           begin
              setlength(tempwav,Nofsamples*2);
              setlength(wavdata,Nofsamples);
              wav_in.ReadSampleData(Nofsamples*2,samplesRead,tempwav);
              if radiogroup5.ItemIndex=0 then woffset:=0 else woffset:=1;
              for i:=1 to nofsamples do
              begin
                 wavdata[i]:=tempwav[woffset+(2*i)];
              end;
              samplesread:=nofsamples;
              setlength(tempwav,0);
           end;
           startsample:=0;
           eindsample:=nofsamples;

           label33.caption:=inttostr(SamplesRead);
           label34.caption:=floattostr(Samplesread/rate);
           if Nofsamples<>SamplesRead then Showmessage('Not all data were read!');

            //amplifier
           if checkbox78.Checked then
           begin
             amplify:=trunc(rxspinedit16.value);
             if amplify<>0 then
             begin
              for i:=0 to samplesread do
              begin
               sample:=amplify*wavdata[i];
               if sample>32767 then sample:=32767;
               if sample<-32767 then sample:=-32767;
               wavdata[i]:=sample;
              end;
             end;
           end;

           if checkbox38.Checked then
           begin
             wavmax:=0;
            for i:=1 to samplesread do
            begin
              if  wavdata[i]>abs(wavmax) then wavmax:=wavdata[i];
            end;
           end;

           if checkbox74.Checked then
           begin
             BPfilterini;
             randomize;
             for i:=1 to Nofsamples do
             begin
               temp:=Random;
               temp:=temp-0.5;
               BPfiltersampledouble(temp);
               wavdata[i]:=round(wavdata[i]+(scrollbar4.position*temp));
             end;
           end;;

           //subsample by 2: LP filter
           if checkbox56.Checked then
           begin
                StartLPfilter;
                LPfilter;
           end;
           //actual subsampling
           if checkbox56.Checked then
           begin
            for i:=1 to (samplesread div 2)  do
            begin
              s1:=wavdata[(2*i)];
              s2:=wavdata[(2*i)+1];
              wavdata[i]:=(s1+s2) div 2;
            end;
            rate:=rate div 2;
            startsample:=0;
            Nofsamples:=Nofsamples div 2;
            Eindsample:=Nofsamples;
            setlength(wavdata,Nofsamples);
           end;

           if checkbox58.Checked then
           begin
            for i:=1 to (samplesread div 4)  do
            begin
              s1:=wavdata[(4*i)];
              s2:=wavdata[(4*i)+1];
              s2:=wavdata[(4*i)+2];
              s2:=wavdata[(4*i)+3];
              wavdata[i]:=(s1+s2+S3+S4) div 4;
            end;
            rate:=rate div 4;
            startsample:=0;
            Nofsamples:=Nofsamples div 4;
            Eindsample:=Nofsamples;
            setlength(wavdata,Nofsamples);
           end;
      end;
      if (not clustering) then wav_in.flush;
      wav_in.close;
      wav_in.Free;

      fileread:=true;
      filefiltered:=false;

      if pagecontrol1.ActivePage=Tabsheet2 then 
      begin
       if checkbox8.Checked then
       begin
        if checkbox3.Checked then
        begin
         clip:=wavefile.create;
         clip.Init;
         deletefile('$$$.wav');
         clip.openforwrite('$$$.wav',rate,16,1,result);
         clip.WriteSampledata(eindsample-startsample,written,wavdata[startsample]);
         if (written<>(eindsample-startsample)) then showmessage('ERROR WRITING SOUND CLIP');
         clip.flush;
         clip.Close;
         clip.free;
        end;
       end
       else
        begin
         clip:=wavefile.create;
         clip.Init;
         deletefile('$$$.wav');
         clip.openforwrite('$$$.wav',rate,16,1,result);
         clip.WriteSampledata(eindsample-startsample,written,wavdata[startsample]);
         if (written<>(eindsample-startsample)) then showmessage('ERROR WRITING SOUND CLIP');
         clip.flush;
         clip.Close;
         clip.free;
        end;
      end;
      prevstartsample:=startsample;
      preveindsample:=eindsample;
 end;
end;

procedure TForm1.StartHPfilter;
var j:integer;
    Temp:double;
begin
  recalcsonogram:=true;
  if Rate=0 then
       showmessage('Read WAV file before making Filter Graph!')
  else
     begin
         HPtaps:=trunc(rxspinedit2.value);
         HPfreq:=rxspinedit3.Value/rate;
         Temp:=HPfreq*rate;
         HPfreq:=Temp/rate;
         if checkbox24.Checked then HPnormal:=1 else HPnormal:=0;
         case combobox4.ItemIndex of
             -1:HPWINDOW:=NSP_WINBLACKMANOPT;
              0:HPWindow:=NSP_WINRECT;
              1:HPWINDOW:=NSP_WINBARTLETT;
              2:HPWINDOW:=NSP_WINBLACKMANOPT;
              3:HPWINDOW:=NSP_WINHAMMING;
              4:HPWINDOW:=NSP_WINHANN;
         end;
         NSPDFirHighPass(HPFreq,@HPCoeff,HPtaps,HPwindow,HPnormal);
         for j:=1 to 1 do NSPdfirINIT(@HPCoeff,HPTaps,nil,HPchannelState[j]);
     end;
end;

procedure TForm1.StartHPfilterW;
var i,j:integer;
    Temp:double;
begin
  recalcsonogram:=true;
  if Rate=0 then
       showmessage('Read WAV file before making Filter Graph!')
  else
     begin
         HPtaps:=trunc(rxspinedit2.value);
         HPfreq:=rxspinedit3.Value/rate;
         Temp:=HPfreq*rate;
         HPfreq:=Temp/rate;
         if checkbox24.Checked then HPnormal:=1 else HPnormal:=0;
         case combobox4.ItemIndex of
             -1:HPWINDOW:=NSP_WINBLACKMANOPT;
              0:HPWindow:=NSP_WINRECT;
              1:HPWINDOW:=NSP_WINBARTLETT;
              2:HPWINDOW:=NSP_WINBLACKMANOPT;
              3:HPWINDOW:=NSP_WINHAMMING;
              4:HPWINDOW:=NSP_WINHANN;
         end;
         NSPdFirHighPass(HPFreq,@HPCoeffS,HPtaps,HPwindow,HPnormal);
         for i:=0 to HPtaps do HPcoeffs[i]:=HPcoeff[i];
         NSPWfirINIT(@HPCoeffS,HPTaps,nil,HPchannelState[1]);
     end;
end;


procedure TForm1.StartLPfilter;
var j:integer;
    Temp:double;
    LPfreqHz:integer;
begin
  recalcsonogram:=true;
  if Rate=0 then
       showmessage('Read WAV file before making Filter Graph!')
  else
     begin
         LPtaps:=499;
         LPfreqHz:=11000;
         LPfreq:=LPfreqHz/rate;
         Temp:=LPfreq*rate;
         LPfreq:=Temp/rate;
         if checkbox24.Checked then LPnormal:=1 else LPnormal:=0;
         case combobox4.ItemIndex of
             -1:LPWINDOW:=NSP_WINBLACKMANOPT;
              0:LPWindow:=NSP_WINRECT;
              1:LPWINDOW:=NSP_WINBARTLETT;
              2:LPWINDOW:=NSP_WINBLACKMANOPT;
              3:LPWINDOW:=NSP_WINHAMMING;
              4:LPWINDOW:=NSP_WINHANN;
         end;
         NSPDFirLowPass(LPFreq,@LPCoeff,LPtaps,LPwindow,LPnormal);
         for j:=1 to 1 do NSPdfirINIT(@LPCoeff,LPTaps,nil,LPchannelState[j]);
     end;
end;

procedure TForm1.LPfilterSyllable(start,eind:Integer);
var j:integer;
    Temp:double;
    LPfreqHz:integer;
    i:integer;
    testsample:smallint;
begin
  recalcsonogram:=true;
  if Rate=0 then
       showmessage('Read WAV file before making Filter Graph!')
  else
     begin
         LPtaps:=37;
         LPfreqHz:=2000;
         LPfreq:=LPfreqHz/rate;
         Temp:=LPfreq*rate;
         LPfreq:=Temp/rate;
         LPnormal:=0;
         lpWINDOW:=NSP_WINBLACKMANOPT;
         NSPDFirLowPass(LPFreq,@LPCoeff,LPtaps,LPwindow,LPnormal);
         for j:=1 to 1 do NSPdfirINIT(@LPCoeff,LPTaps,nil,LPchannelState[j]);
     end;
     for i:=start to eind do
     begin
        testsample:=wavdata[i];
        temp:=nspdFir(LPchannelState[1],testsample);
        syl_wavdata[i-start]:=round(temp);
     end;
end;

procedure TForm1.StartLPfilterW;
var i,j:integer;
    Temp:double;
    LPfreqHz:integer;
begin
  recalcsonogram:=true;
  if Rate=0 then
       showmessage('Read WAV file before making Filter Graph!')
  else
     begin
         LPtaps:=499;
         LPfreqHz:=11000;
         LPfreq:=LPfreqHz/rate;
         Temp:=LPfreq*rate;
         LPfreq:=Temp/rate;
         if checkbox24.Checked then LPnormal:=1 else LPnormal:=0;
         case combobox4.ItemIndex of
             -1:LPWINDOW:=NSP_WINBLACKMANOPT;
              0:LPWindow:=NSP_WINRECT;
              1:LPWINDOW:=NSP_WINBARTLETT;
              2:LPWINDOW:=NSP_WINBLACKMANOPT;
              3:LPWINDOW:=NSP_WINHAMMING;
              4:LPWINDOW:=NSP_WINHANN;
         end;
         NSPDFirLowPass(LPFreq,@LPCoeff,LPtaps,LPwindow,LPnormal);
         for i:=0 to LPtaps do LPcoeffs[i]:=LPcoeff[i];
         NSPWfirINIT(@LPCoeffS,LPTaps,nil,LPchannelState[1]);
     end;
end;

procedure Tform1.filter;
var i:integer;
    Temp:double;
    testsample:smallint;
    scalefactor:INTEGER;
begin
    statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
    if checkbox28.Checked then rxgifanimator4.show;
    memo1.Lines.Add('filter '+DateTimeToStr(Now));
    StartHPFilterW;
    scalefactor:=0;
    for i:=0 to nofSamples-1 do
    begin
        wavdata[i]:=nspwFir(HPchannelState[1],wavdata[i],NSP_NO_SCALE,scalefactor);
    end;
    filefiltered:=true;
    statusbar1.Panels[4].Text:='';statusbar1.Update;
    rxgifanimator4.hide;
end;

procedure Tform1.LPfilter;
var i:integer;
    Temp:double;
    testsample:smallint;
begin
    statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
    if checkbox28.Checked then rxgifanimator4.show;
    memo1.Lines.Add('filter '+DateTimeToStr(Now));

     for i:=0 to nofSamples-1 do
     begin
        testsample:=wavdata[i];
        //testsample:=testsample-RAvg(testsample);
        temp:=round(nspdFir(LPchannelState[1],testsample));
        wavdata[i]:=round(temp);
     end;
     //if checkbox2.checked then chart;
     filefiltered:=true;

     statusbar1.Panels[4].Text:='';statusbar1.Update;
     rxgifanimator4.hide;
end;



procedure Tform1.filter2;
var i:integer;
    Temp:double;
    testsample:smallint;
begin
    statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
    if checkbox28.Checked then rxgifanimator4.show;
    memo1.Lines.Add('filter '+DateTimeToStr(Now));
    for i:=0 to nofSamples-1 do
    begin
        testsample:=wavdata[i];
        wavdata[i]:=testsample-RAvg(testsample);
    end;
    filefiltered:=true;
    statusbar1.Panels[4].Text:='';statusbar1.Update;
    rxgifanimator4.hide;
end;


procedure Tform1.chart2;
var i:integer;
    time:double;
    localshow:boolean;
    testval:integer;
    prevgatelevel,gatelevel:integer;
    prevgateswitch,gateswitch:integer;
    gateinterval:double;
    gatetime:double;
    t1,t2,freq:int64;
    elapsed:integer;
    //tempdata:array of smallint;
    doenvelop1,doenvelop2:boolean;
    testhi,testlo:extended;
    gridrow:integer;
    yleft,yright,xtop,xbottom:integer;
    written:integer;
    clip:wavefile;
    result:boolean;
    testgate:integer;
    testgatelevel:integer;
    fastnoise:boolean;
    j:integer;
    sono2time:double;
    testlevel:integer;
    testcountlevel:longint;
    darkcount:int64;
    Lofreq,Hifreq:integer;
    freq2bin:double;
    currentbin:integer;
    pixelvalue:integer;
    testbin:integer;
    startcol,eindcol:integer;
    lotime,hitime:integer;
    realstart:integer;
    currenttime:double;
    realgatelevel:integer;
    gatecol:integer;
    clip32:Tbitmap32;
    wenthigh:integer;
    hasbeenhigh:boolean;
    cols:integer;
    resolution:integer;
    t:TTimestamp;
    int1,int2:integer;
    notgateinterval:double;
    g1,g2:double;
    gridrow2:integer;
    tempvar:double;
    tempint:int64;
    tempval:int64;
begin
 //if not form1.Regware41.expired then
 begin
  queryperformancecounter(T1);
   if checkbox28.Checked then rxgifanimator4.show;
   if checkbox29.Checked then
   begin
     statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
     memo1.Lines.Add('chart2 '+DateTimeToStr(Now));
   end;

   if (prevstartsample<>startsample) or (preveindsample<>eindsample) then
   begin
     clip:=wavefile.create;
     clip.Init;
     deletefile('$$$.wav');
     clip.openforwrite('$$$.wav',rate,16,1,result);
     clip.WriteSampledata(eindsample-startsample,written,wavdata[startsample]);
     if (written<>(eindsample-startsample)) then showmessage('ERROR WRITING SOUND CLIP');
     clip.Close;
     clip.free;
   end;
   prevstartsample:=startsample;
   preveindsample:=eindsample;

   if checkbox13.Checked then StartLPfilter;
   prevgatelevel:=0;
   prevgateswitch:=0;
   rfjchart2.buffered:=true;
   rfjchart2.traces:=channelcount;
   scrollbar5.Hide;
   rfjchart2.drawmode:=dmline;
   rfjchart2.start:=RXSPINEDIT12.VALUE;
   rfjchart2.eind:=RXSPINEDIT13.VALUE;


   //Do this first: needed for proper alignment
   //Sonogram
   adjusttime:=false;
   if checkbox5.Checked then
   begin
    if adjusttime then
     begin
      StartCol:=trunc(Startsample/samplesperbin);
      EindCol:=trunc(Eindsample/samplesperbin);
      StartSample:=trunc(Startcol*samplesperbin);
      EindSample:=trunc(EindCol*Samplesperbin);
      rxspinedit12.value:=startsample*(1000/rate);
      rxspinedit13.value:=eindsample*(1000/rate);
      rfjchart2.start:=RXSPINEDIT12.VALUE;
      rfjchart2.eind:=RXSPINEDIT13.VALUE;
     end
    else
     begin
      rfjchart2.start:=RXSPINEDIT12.VALUE;
      rfjchart2.eind:=RXSPINEDIT13.VALUE;
     end;
   end;


  //waveforms
   if checkbox23.Checked then
   begin
     rfjchart2.trace[wchannel].clipy:=true;
     rfjchart2.trace[wchannel].pen.color:=clblack;
     rfjchart2.trace[wchannel].xaxispen.color:=clblack;
     rfjchart2.trace[wchannel].yaxispen.color:=clblack;
     rfjchart2.trace[wchannel].graphtitle:=currentfile;
     rfjchart2.trace[wchannel].showtitle:=true;
     rfjchart2.trace[wchannel].yaxislegend:='';
     if checkbox38.Checked then
     begin
           wavmax:=0;
           for i:=StartSample+1 to Eindsample-1 do
           begin
              if i<nofsamples then
                if  wavdata[i]>abs(wavmax) then wavmax:=wavdata[i];
           end;
           slideposition[2]:=wavmax;
           if slide2[wchannel]<>nil then slide2[wchannel].Position:=wavmax;
     end;
     rfjchart2.trace[wchannel].ygmax:=slideposition[2];
     rfjchart2.trace[wchannel].ygmin:=-slideposition[2];
     rfjchart2.setmemsize(wchannel,(1+Eindsample-StartSample));
   end;

   //sonogram;
   if checkbox5.Checked then
   begin
     rfjchart2.trace[schannel].imagefilter:=1+combobox8.ItemIndex;
     rfjchart2.trace[schannel].clipy:=true;
     rfjchart2.trace[schannel].pen.color:=clblack;
     rfjchart2.trace[schannel].xaxispen.color:=clblack;
     rfjchart2.trace[schannel].yaxispen.color:=clblack;
     rfjchart2.trace[schannel].graphtitle:='';
     rfjchart2.trace[schannel].showtitle:=true;
     rfjchart2.trace[schannel].yaxislegend:='';
     rfjchart2.trace[schannel].ygmax:=trunc(rxspinedit21.value);
     rfjchart2.trace[schannel].ygmin:=0;
     rfjchart2.showimage:=true;
   end;

   //envelope
   if checkbox36.Checked then
   begin
     rfjchart2.trace[echannel].ygmax:=slideposition[6];
     rfjchart2.trace[echannel].clipy:=true;
     rfjchart2.trace[echannel].ygmin:=0;
     rfjchart2.trace[echannel].pen.color:=clblack;
     rfjchart2.trace[echannel].xaxispen.color:=clblack;
     rfjchart2.trace[echannel].yaxispen.color:=clblack;
     rfjchart2.trace[echannel].graphtitle:='';
     rfjchart2.trace[echannel].showtitle:=true;
     rfjchart2.trace[echannel].yaxislegend:='';
     rfjchart2.setmemsize(echannel,(1+Eindsample-StartSample));
     //rfjchart2.setymark(echannel,slideposition[5]);
   end;

   //Gate
   if checkbox16.Checked then
   begin
     rfjchart2.trace[gchannel].clipy:=true;
     rfjchart2.trace[gchannel].pen.color:=clblack;
     rfjchart2.trace[gchannel].xaxispen.color:=clblack;
     rfjchart2.trace[gchannel].yaxispen.color:=clblack;
     rfjchart2.trace[gchannel].graphtitle:='';
     rfjchart2.trace[gchannel].showtitle:=true;
     rfjchart2.trace[gchannel].yaxislegend:='';
     rfjchart2.trace[gchannel].ygmax:=100;
     rfjchart2.trace[gchannel].ygmin:=-10;
     rfjchart2.setmemsize(gchannel,(1+Eindsample-StartSample));
     rfjchart2.trace[gchannel].traceheightfixed:=true;
     rfjchart2.trace[gchannel].traceheight:=rfjchart2.Height div 6;
     rfjchart2.trace[echannel].showtitle:=true;
     if checkbox16.checked then
     begin
       if slide[echannel]<> nil then
       begin
         testhi:=(slide[echannel].max-slide[echannel].Position);
         testlo:=(slide[echannel].max-slide[echannel].Position-rxspinedit22.value);
         rfjchart2.trace[echannel].graphtitle:='Gate Levels='+inttostr(trunc(testhi))+' ,'+inttostr(trunc(testlo));
       end;
     end;
    end;

   //calculate graph metrics using these values
   rfjchart2.backcolor:=clwhite;
   rfjchart2.drawmode:=dmpoint;
   rfjchart2.usestoredsettings:=true;
   if checkbox66.Checked and checkbox5.Checked then   //scroll and sonogram
   begin
      if checkbox25.Checked then
         resolution:=trunc(rxspinedit4.value)
      else
         resolution:=strtoint(combobox1.Items.strings[combobox1.ItemIndex]);
      cols:=rfjchart2.trace[1].ymarginright+rfjchart2.trace[1].ymarginleft+round((eindsample-startsample)/resolution);
      rfjchart2.ScrollBitmapwidth:=cols;
   end;
   rfjchart2.setuptraces;

   rfjchart2.usestoredsettings:=false;

   //setup Sliders
   panel15.Enabled:=false;
   panel2.enabled:=false;
   for i:=rfjchart2.traces downto 1 do
   begin
       //only executed when a change occurs!!
       if slidepanel[i]=nil then
       begin
         slidepanel[i]:=Tpanel.Create(panel15);
         slidepanel[i].Align:=altop;
         slidepanel[i].Parent:=panel15;
         slidepanel[i].Height:=trunc(rfjchart2.trace[i].traceheight);
         slidepanel[i].Show;
         slide[i]:=Tscrollbar.Create(slidepanel[i]);
         slide[i].Align:=alclient;
         slide[i].Parent:=slidepanel[i];
         slide[i].kind:=sbvertical;
         slide[i].Hide;
         if i=wchannel then
         begin
           slide[i].Min:=-3276;
           slide[i].Max:=3276;
           slide[i].position:=0;
           slide[i].LargeChange:=(slide[i].Max-slide[i].min) div 20 ;
           slide[i].SmallChange:=(slide[i].Max-slide[i].min) div 20 ;
           slide[i].Position:=slideposition[1];
           slide[i].onchange:=wchannel_leftscroll_change;
           slide[i].width:=5;
           slide[i].Hint:='LEVEL CONTROL FOR COUNT';
           slide[i].ShowHint:=true;
         end;
         if i=echannel then
         begin
           slide[i].Min:=0;
           slide[i].Max:=slideposition[6];
           slide[i].Position:=slideposition[5];
           slide[i].onchange:=echannel_leftscroll_change;
           slide[i].LargeChange:=(slide[i].Max-slide[i].min) div 50 ;
           slide[i].SmallChange:=(slide[i].Max-slide[i].min) div 50 ;
         end;
         if i=schannel then
         begin
           //needs dynamic control !!!!
           colors:=Tcolor_calibrate.Create(slidepanel[i]);
           colors.Parent:=slidepanel[i];
           colors.align:=alclient;
           colors.Orientation:=-2;
           colors.ColorTable:=4;
           colors.Minvalue:=0;
           colors.Maxvalue:=1024;
           colors.show;
           //colors.onclick:=schannel_colors_click;
           slide[i].Min:=0;
           slide[i].Enabled:=true;
           slide[i].Max:=slideposition[3];
           slide[i].Position:=slideposition[3];
           slide[i].onchange:=schannel_leftscroll_change;
           slide[i].LargeChange:=10;
           slide[i].SmallChange:=1;
           slide[i].Hide;
         end;
         slide[i].Show;
         if i=gchannel then
         begin
           slide[i].hide;
         end;
       end;

       //only executed when a change occurs!!
       if slidepanel2[i]=nil then
       begin
         slidepanel2[i]:=Tpanel.Create(panel2);
         slidepanel2[i].Align:=altop;
         slidepanel2[i].Parent:=panel2;
         slidepanel2[i].Height:=trunc(rfjchart2.trace[i].traceheight);
         slidepanel2[i].Show;
         slide2[i]:=Tscrollbar.Create(slidepanel2[i]);
         slide2[i].Align:=alclient;
         slide2[i].Parent:=slidepanel2[i];
         slide2[i].kind:=sbvertical;
         slide2[i].Hide;
         if i=schannel then
         begin
           slide2[i].Min:=0;
           slide2[i].Max:=50;
           slide2[i].Position:=slideposition[4];
           slide2[i].onchange:=schannel_rightscroll_change;
         end;
         if i=echannel then
         begin
           slide2[i].Min:=0;
           slide2[i].Max:=30000;
           slide2[i].LargeChange:=(slide2[i].Max-slide2[i].min) div 20 ;
           slide2[i].SmallChange:=(slide2[i].Max-slide2[i].min) div 20 ;
           slide2[i].Position:=slideposition[6];
           slide2[i].onchange:=echannel_rightscroll_change;
         end;
         if i=wchannel then
         begin
           slide2[i].Min:=0;
           slide2[i].Max:=32767;
           if checkbox38.Checked then slideposition[2]:=wavmax;
           slide2[i].Position:=slideposition[2];
           slide2[i].LargeChange:=(slide2[i].Max-slide2[i].min) div 20 ;
           slide2[i].SmallChange:=(slide2[i].Max-slide2[i].min) div 20 ;
           slide2[i].onchange:=wchannel_rightscroll_change;
           rfjchart2.trace[i].ygmax:=slide2[i].Position;
           rfjchart2.trace[i].ygmin:=-slide2[i].Position;
         end;
         slide2[i].Show;
         if i=gchannel then
         begin
           slide2[i].hide;
         end;
       end;
   end;
   panel15.enabled:=true;
   panel2.enabled:=true;

   //rfjchart2.setmemsize(echannel,Nofsamples);
   runningavgcount:=round(rxspinedit7.value);  //envelope

   //Sonogram
   if checkbox5.Checked then
   begin
     if recalcsonogram then if checkbox47.Checked then aho_sonogram2 else sonogram2;
     rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   end;

   rfjchart2.drawaxes;
   rfjchart2.reset;
   if fbmp2.width>0 then sono2time:=(eindsample-startsample)/fbmp2.Width;

   //Wave
   if checkbox23.Checked then
   begin
     rfjchart2.drawmode:=dmline;
     rfjchart2.addarray(wchannel,0,1000/rate,startsample,eindsample,0,wavdata);
     if checkbox8.Checked then
     begin
       rfjchart2.setymark(wchannel,slide[wchannel].Position);
       rfjchart2.setymark(wchannel,-slide[wchannel].Position);
     end;
   end;

   //ENVELOPE
   //if checkbox46.Checked then env_calc:=false;
   if checkbox36.checked then
   begin
    rfjchart2.drawmode:=dmline;
    if not checkbox16.checked then slide[echannel].hide else slide[echannel].show;
    slide[echannel].Max:=round(rfjchart2.trace[echannel].ygmax);
    slide[echannel].largechange:=(slide[echannel].Max-slide[echannel].min) div 50 ;
    slide[echannel].smallchange:=(slide[echannel].Max-slide[echannel].min) div 50 ;

    //sonogram-envelope
    if (not env_calc) and checkbox46.Checked then
    begin
      sono2time:=(eindsample-startsample)/fbmp2.Width;
      freq2bin:=(rfjchart2.trace[schannel].ygmax-rfjchart2.trace[schannel].ygmin)/fbmp2.Height;
      lofreq:=fbmp2.height-round(rxspinedit35.value/freq2bin);
      hifreq:=fbmp2.height-round(rxspinedit36.value/freq2bin);
      if (rxspinedit21.value<rxspinedit36.value) then
            hifreq:=fbmp2.height-round(rxspinedit21.value/freq2bin);
      testlevel:=trunc(rxspinedit34.value);
      setlength(ebuffer,nofsamples);
      currentbin:=-1;
      //setlength(testbuffer,1+Eindsample-startsample);
      for i:=startsample to eindsample-1 do
      begin
        testbin:=trunc((i-startsample)/sono2time);
        if currentbin<> testbin then
        begin
         darkcount:=0;
         currentbin:=testbin;
         for j:=hifreq to lofreq do
         begin
            pixelvalue:=redcomponent(fbmp2.PixelS[currentbin,j]);

            //if not checkbox51.Checked then if pixelvalue<=testlevel then inc(darkcount,100);

            //modified rfj june 2004;
            if not checkbox51.Checked then
              if pixelvalue<=testlevel then
              begin
                 darkcount:=darkcount+255-pixelvalue;
                 //added value if pixel=255 --> overflow
                 //if pixelvalue=0 then darkcount:=darkcount+255;
              end;
            
            // dpower/dfreq
            if checkbox51.Checked then if (pixelvalue<64) or (pixelvalue>192) then inc(darkcount,100);
         end;
        end;
        ebuffer[i]:=darkcount;
        tempvar:=darkcount;
        tempval:=i;gatetime:=(1000*tempval)/rate;
        rfjchart2.addpoint(echannel,gatetime,tempvar);
      end;
       if checkbox21.Checked then showbmphis;
    end;

    //ravg-envelope
    if not env_calc and checkbox11.checked then
    begin
     if checkbox46.Checked then
     begin
      setlength(ebuffer,nofsamples);
      for i:=startsample to eindsample-1 do
      begin
        if i<nofsamples then
        begin
          testval:=envelope(wavdata[i]);
          ebuffer[i]:=testval;
        end;
      end;
     end;

     //FIR-envelope
     if (not env_calc) and checkbox13.Checked then
     begin
      setlength(ebuffer,nofsamples);
      for i:=startsample to eindsample-1 do
      begin
       if i<nofsamples then
       begin
        testval:=envelope2(wavdata[i]);
        ebuffer[i]:=testval;
       end;
      end;
     end;
    end;
    if not checkbox46.checked then rfjchart2.addarray(echannel,0,1000/rate,startsample,eindsample-1,ebuffer);

    rfjchart2.setymark(echannel,(slide[echannel].max-slide[echannel].Position));
    rfjchart2.setymark(echannel,(slide[echannel].max-slide[echannel].Position-trunc(rxspinedit22.value)));
    env_calc:=true;
    rfjchart2.drawmode:=dmpoint;
   end;

   //GATE
   //if checkbox16.Checked then
   //begin
   //  slide[echannel].show;
   //  rfjchart2.drawmode:=dmline;
   //  rfjchart2.reset;
   //  echannel_leftscroll_change(self);
   //end;

   if checkbox16.Checked then
   begin
    //form10.Show;

    if form22.CheckBox1.Checked or form22.CheckBox2.Checked then
    begin
       form22.advspreadgrid1.hide;
       form22.advspreadgrid1.Clear;
       form22.advspreadgrid1.RowCount:=0;
       form22.Update;
    end;

    slide[echannel].show;
    rfjchart2.drawmode:=dmline;
    rfjchart2.reset;
    testhi:=(slide[echannel].max-slide[echannel].Position);
    testlo:=(slide[echannel].max-slide[echannel].Position-rxspinedit22.value);
    advstringgrid1.Clear;
    gridrow:=-1;

    xoffset:=0;
    if advspreadgrid1.Cells[4,currentrow]<>'' then
      begin
        T:=DateTimeToTimeStamp(strtofloat(advspreadgrid1.Cells[4,currentrow]));
        xoffset:=T.Time;
        xoffset:=round(strtofloat(advspreadgrid1.Cells[6,currentrow]));  //rjrjrj        
    end;
    if checkbox53.Checked then xoffset:=0;

    if checkbox52.checked then
    begin
     info2spreadsheet;
     gridrow:=0;
    end;
    if (ebuffer[startsample]>testhi) then prevgatelevel:=90 ;
    if (ebuffer[startsample]<testlo) then prevgatelevel:=0;
    hitime:=trunc(rate*rxspinedit24.value/1000);
    lotime:=trunc(rate*rxspinedit6.value/1000);

    //ravg-envelope en fir-envelope en sonogram envelope
    if checkbox11.Checked or checkbox13.Checked or checkbox46.Checked then
    begin
      //for i:=startsample to eindsample-1 do
      //begin
      i:=startsample;
      realstart:=startsample;
      fastnoise:=false;
      while i<eindsample-1 do
      begin
          if realstart>i then
          begin
             i:=realstart;
             //prevgatelevel:=realgatelevel;
          end;
          if (ebuffer[i]>testhi) then gatelevel:=90 ;
          if (ebuffer[i]<testlo) then gatelevel:=0;
          if prevgatelevel=gatelevel then
          begin
            tempval:=i;gatetime:=1000*tempval/rate;
            rfjchart2.addpoint(gchannel,gatetime,gatelevel);
          end;
          if prevgatelevel<>gatelevel then
          begin
             //transition?
             fastnoise:=false;
             if gatelevel=90 then testgate:=hitime;
             if gatelevel=0 then testgate:=lotime;
             for j:=i to (i+testgate) do
             begin
                  if (ebuffer[j]>testhi) then testgatelevel:=90 ;
                  if (ebuffer[j]<testlo) then testgatelevel:=0;
                  if testgatelevel<>gatelevel then
                  begin
                     fastnoise:=true;
                     realstart:=j;
                     //realgatelevel:=testgatelevel;
                     break;
                  end;
             end;
             if fastnoise then gatelevel:=prevgatelevel;
             if not fastnoise then
             begin
               prevgateswitch:=gateswitch;
               gateswitch:=i;
               //gateinterval:=1000*((gateswitch-prevgateswitch)/rate);
               tempval:=i;
               gatetime:=(1000*tempval)/rate;
               if gatelevel=90 then
               begin
                   inc(gridrow);
                   if gridrow>(advstringgrid1.RowCount-1) then advstringgrid1.RowCount:=advstringgrid1.RowCount+1;
                   advstringgrid1.Cells[0,gridrow]:=(floattostrf(xoffset+gatetime,fffixed,12,2));
                   if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
                   //
                   gatecol:=ceil(((gatetime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);
                   hasbeenhigh:=true;
                   wenthigh:=gatecol;
                   //
                   //only if we want to measure silent intervals as well  for rr-plot
                   if (gridrow>0) and form22.checkbox2.checked then
                   begin
                      inc(gridrow2);
                      g1:=strtofloat(advstringgrid1.Cells[1,gridrow-1]);
                      g2:=strtofloat(advstringgrid1.Cells[0,gridrow]);
                      notgateinterval:=g2-g1;
                      form22.advspreadgrid1.RowCount:=gridrow2;
                      form22.advspreadgrid1.Cells[1,gridrow2]:=inttostr(gridrow2+1);
                      form22.advspreadgrid1.Cells[2,gridrow2]:=(floattostrf(notgateinterval,fffixed,6,2));
                      form22.advspreadgrid1.RowColor[gridrow2]:=clteal;
                    end;
                   //
               end;
               if gatelevel=0 then
               begin
                    gateinterval:=1000*((gateswitch-prevgateswitch)/rate);
                    if gridrow<0 then
                    begin
                      gridrow:=0;
                      gateinterval:=0;
                    end;
                    advstringgrid1.Cells[1,gridrow]:=(floattostrf(xoffset+gatetime,fffixed,12,2));
                    advstringgrid1.Cells[2,gridrow]:=(floattostrf(gateinterval,fffixed,6,2));
                    if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
                    //
                    //sound intervals for rr-plot
                    if (gridrow>=0) and form22.checkbox1.checked then
                    begin
                               inc(gridrow2);
                               form22.advspreadgrid1.RowCount:=gridrow2;
                               form22.advspreadgrid1.Cells[1,gridrow2]:=inttostr(gridrow2+1);
                               form22.advspreadgrid1.Cells[2,gridrow2]:=(floattostrf(gateinterval,fffixed,6,2));
                    end;
                    //
                    gatecol:=trunc(((gatetime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);
                    if hasbeenhigh and save_db then
                    begin
                     FStream := TMemoryStream.Create;
                     clip32.Width:=gatecol-wenthigh;
                     clip32.height:=fbmp2.Height;
                     fbmp2.DrawTo(clip32,
                                 rect(0,0,clip32.width-1,clip32.Height),
                                 rect(wenthigh-2,0,gatecol+2,fbmp2.height));

                     //clip32.SaveToClipboard;
                     png.CompressionLevel:=9;
                     png.Filters:=[pfNone, pfSub, pfUp, pfAverage, pfPaeth];
                     clip32.AssignTo(clip);
                     PNG.assign(clip);
                     png.SaveToStream(FStream);
                     FStream.seek(0,0);
                     FHead.Magic := 1234567; //constant value
                     FHead.BitmapSize := FStream.size;
                     FHead.edit1string := currentfile;
                     FHead.edit2string := floattostr(gatetime);
                     FHead.edit3string := 'dummytext';
                     FFile.Write(FHead,SizeOf(TMyRecord));
                     FFile.CopyFrom(FStream,FStream.size );
                     fstream.free;
                    end;
                    //
               end;
               tempval:=i;gatetime:=(1000*tempval)/rate;
               rfjchart2.addpoint(gchannel,gatetime,gatelevel);
               prevgatelevel:=gatelevel;
             end;
          end;
          inc(i);
      end;
    end;
    //
    if pagecontrol2.ActivePage=pagecontrol2.Pages[0] then makegatehis;
    if pagecontrol2.ActivePage=pagecontrol2.Pages[1] then makedurationhis;
   end;

   if checkbox36.checked then
   begin
       rfjchart2.setymark(schannel,trunc(rxspinedit35.value),clred32);
       rfjchart2.setymark(schannel,trunc(rxspinedit36.value),clred32);
   end;


   rfjchart2.update;

   lockupdate:=true;
     rxspinedit29.Value:=rfjchart2.trace[wchannel].traceheight;
     rxspinedit30.Value:=rfjchart2.trace[schannel].traceheight;
     if rfjchart2.trace[echannel].traceheight>1000 then rfjchart2.trace[echannel].traceheight:=0;
     rxspinedit31.Value:=rfjchart2.trace[echannel].traceheight;
     if rfjchart2.trace[gchannel].traceheight>1000 then rfjchart2.trace[gchannel].traceheight:=0;     
     rxspinedit32.Value:=rfjchart2.trace[gchannel].traceheight;
   lockupdate:=false;

   if checkbox29.Checked then
   begin
     queryperformancecounter(T2);
     queryperformancefrequency(freq);
     elapsed:=round((rate/(eindsample-startsample))*1000*(t2-T1)/freq);
     memo1.Lines.Add(inttostr(elapsed)+' chart2 '+DateTimeToStr(Now));
   end;
   statusbar1.Panels[4].Text:='';statusbar1.Update;
   rxgifanimator4.hide;

  // if checkbox6.Checked then form8.LUTControl1Change(self);
 end;
 if firstshow then
 begin
     firstshow:=false;
     rxspinedit29.Value:=rxspinedit30.value*0.50;
     RxSpinEdit29Change(self);
 end;

 if checkbox36.Checked then
   with form22 do
   begin
        for i:=0 to advspreadgrid1.RowCount-2 do
        begin
          if AdvSpreadGrid1.Cells[2,i]='' then
          begin
            AdvSpreadGrid1.RemoveRows(i,1);
          end;
       end;

       advspreadgrid1.SortSettings.Column:=2;
       advspreadgrid1.QSort;
       for i:=0 to advspreadgrid1.RowCount-1 do
       begin
          AdvSpreadGrid1.Cells[3,i]:=inttostr(i+1);
       end;
       advspreadgrid1.SortSettings.Column:=1;
       advspreadgrid1.QSort;
       advspreadgrid1.Show;
       {
       rfjchart1.traces:=1;
       rfjchart1.start:=0;
       rfjchart1.eind:=advspreadgrid1.RowCount;
       rfjchart1.trace[1].ygmin:=0;
       rfjchart1.trace[1].ygmax:=advspreadgrid1.RowCount;
       rfjchart1.drawmode:=dmpoint;
       rfjchart1.trace[1].yaxislegend:='';
       rfjchart1.trace[1].graphtitle:= opendialog1.FileName;
       rfjchart1.trace[1].showtitle:=true;
       rfjchart1.setuptraces;
       rfjchart1.drawaxes;
       for i:=0 to form22.advspreadgrid1.RowCount-2 do
       begin
          int1:=strtoint(AdvSpreadGrid1.Cells[3,i]);
          int2:=strtoint(AdvSpreadGrid1.Cells[3,i+1]);
          rfjchart1.addpoint(1,int1,int2);
       end;
       rfjchart1.update;
       }
   end;
   //
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 play;
end;

procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
begin
  FromCSV:=false;
  if opendialog2.execute then
  begin
     advspreadgrid1.rowcount:=1;
     statusbar1.Panels[5].Text:=opendialog1.filename;
     Filepath:=PathWithoutRightElement(form1.opendialog2.filename,'\');
     path:=Filepath;
     advspreadgrid1.LoadFromCSV(opendialog2.filename);
     if checkbox4.Checked then zip:=true else zip:=false;
     FromCSV:=true;
     //fix?
     //for i:=1 to  advspreadGrid1.rowcount-1 do
     //begin
     //    advspreadgrid1.Cells[2,i-1]:=inttostr(trunc(strtofloat(advspreadgrid1.Cells[3,i-1])));
     //end;
  end;
end;

function Tform1.RAvg(Sample:smallint):smallint;
var  OldAvg,NewAvg:double;
begin
   NewAvg:=Sample;
   Trackdatamax:=trunc(rxspinedit33.value);
   if abs(Sample)>32760 then Sample:=0;
   if Trackdatamax > 1 then
    begin
       OldAvg:=TrackAvg;
       NewAvg:=(((Trackdatamax-1)*OldAvg)+Sample)/Trackdatamax;
    end;
   TrackAvg:=NewAvg;
   Result:=round(NewAvg);
end;

procedure Tform1.play;
begin
   jvwaveplayer1.FileName:=opendialog1.FileName;
   jvwaveplayer1.Play;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
   //chart2;
end;

procedure TForm1.getzipfile;
var
   FirstDir: String;
begin
   //if FirstDir = '' then GetSpecialFolder( CSIDL_DESKTOPDIRECTORY, FirstDir );
   with OpenDialog1 do
   //begin
   //   InitialDir := FirstDir;
   //   Title      := 'Open Existing ZIP File';
   //   Filter     := 'ZIP Files (*.ZIP, *.EXE)|*.zip;*.exe';
   //   FileName   := '';
   //   Options := Options + [ofHideReadOnly, ofShareAware, ofPathMustExist, ofFileMustExist];
   //if Execute then
      begin
         FirstDir := ExtractFilePath( FileName );
         { Set the caption after assigning the filename. This
           way, the filename will be null if the open failed. }
         SetZipFName( FileName, True );
         fillgrid;
      end;
end;

function Tform1.GetSpecialFolder( aFolder: Integer; var Location: String ): LongWord;
var
   pidl:      PItemIDList;
   hRes:      HRESULT;
   RealPath:  Array[0..MAX_PATH] of Char;
   Success:   Boolean;
begin
   Result := 0;
   hRes := SHGetSpecialFolderLocation( Handle, aFolder, pidl );
   if hRes = NO_ERROR then
   begin
      Success := SHGetPathFromIDList( pidl, RealPath );
      if Success then
         Location := String( RealPath ) + '\'
      else
         Result := LongWord( E_UNEXPECTED );
   end else
      Result := hRes;
end;

procedure Tform1.SetZipFName( aCaption: String; AssignName: Boolean );
begin
   // Assigning the filename will cause the table of contents to be read.
   // and possibly reset it to an empty string (If error found).
   if AssignName then
      ZipMaster1.ZipFilename := aCaption;

   if ZipMaster1.ZipFilename = '' then
      ZipFName.Caption := AnsiString( '<none>' )
   else
      ZipFName.Caption := MinimizeName( ZipMaster1.ZipFilename, ZipFName.Canvas, ZipFName.Width );

   if ZipFName.Canvas.TextWidth( ZipMaster1.ZipFilename ) > ZipFName.Width then
   begin
      ZipFName.Hint     := ZipMaster1.ZipFilename;
      ZipFName.ShowHint := True;
   end else
      ZipFName.ShowHint := False;
end;

procedure TForm1.FillGrid;
var
  i:  Integer;
  maxfilenamelength:array[0..10] of integer;
  testwidth:integer;
  //so: TSortOptions;
   day,month,yr,hrs,min,sec,timestring,datestring:string;
   wyear,wday,wmonth,wyr,whrs,wmin,wsec:word;
   f1datetime:Tdatetime;
   secinday,msecinday:int64;
begin
  advspreadgrid1.Clear;
  advspreadGrid1.Cells[0, 0] := '0-Filename';
  advspreadGrid1.Cells[1, 0] := '1-Status';
  advspreadGrid1.Cells[2, 0] := '2-Size';
  advspreadGrid1.Cells[3, 0] := '3';
  advspreadGrid1.Cells[4, 0] := '4-Time';
  advspreadGrid1.Cells[5, 0] := '5-Path';
  advspreadGrid1.Cells[6, 0] := '6-MsecinDay';
  with form1.advspreadGrid1 do
  begin
    RowCount := 2;
    //Rows[1].Clear;
    if ZipMaster1.Count = 0 then Exit;
    advspreadGrid1.RowCount := ZipMaster1.Count + 1;
    TotUnComp := 0;
    TotComp   := 0;
    for i := 1 to ZipMaster1.Count do
    begin
       with ZipDirEntry(ZipMaster1.ZipContents[i - 1]^) do
       begin
        if (extractfileExt(Filename)='.wav') or (extractfileExt(Filename)='.WAV') then
        begin
          //advspreadGrid1.Cells[0, i] := copy(ExtractFileName( FileName ),1,length(Filename)-4);
          advspreadGrid1.Cells[0, i] := ExtractFileName( FileName);
          advspreadGrid1.Cells[2, i] := IntToStr( UncompressedSize );
          advspreadGrid1.Cells[5, i] := ExtractFilePath( FileName );
          if (z_ItemCCount(advspreadGrid1.Cells[0, i],'_')-1)=2 then
          begin
           if (z_ItemCCount(advspreadGrid1.Cells[0, i],'_')-1)=2 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, i],1,1,'_');
            datestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, i],2,2,'_');
            if (timestring<>'') and (datestring <>'') then
            begin
              Hrs:=z_SMiddle(Timestring,1,2);
              Min:=z_SMiddle(Timestring,3,2);
              Sec:=z_SMiddle(Timestring,5,2);
              day:=z_SMiddle(datestring,1,2);
              month:=z_SMiddle(datestring,3,2);
              year:=z_SMiddle(datestring,5,2);
              wyear:=2000+ strtoint(year);
              wmonth:=strtoint(month);
              wday:=strtoint(day);
              whrs:=strtoint(hrs);
              wmin:=strtoint(min);
              wsec:=strtoint(sec);
              secinday:=(3600*whrs)+(60*wmin)+wsec;
              msecinday:=1000*secinday;
              advspreadgrid1.cells[6,i]:=inttostr(msecinday);
              f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
              advspreadgrid1.cells[4,i]:=floattostr(f1Datetime);
            end;
           end;
          end;
          if (z_ItemCCount(advspreadGrid1.Cells[0, i],'_')-1)=1 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, i],1,1,'_');
            timestring:=z_SLeft(timestring,z_COccurs(timestring,'.')-1);
            if timestring<>'' then
            begin
              advspreadgrid1.cells[4,i]:=timestring;
            end;
           end;
        end;
       end;
    end;
    advspreadgrid1.RowCount := advspreadgrid1.RowCount;
    advspreadgrid1.SortSettings.Column:=2;
    advspreadgrid1.SortSettings.Direction:=sdDescending;
    advspreadGrid1.Qsort;
    Row := 1;
    fitlist;
  end;
end;


procedure Tform1.count;
var i:integer;
    testlevel:integer;
    levelhis:array[0..32768] of longint;
begin
       //for i:=1 to high(levelhis) do levelhis[i]:=0;
       memo1.Lines.Add('count '+DateTimeToStr(Now));
       abovelevel:=0;
       testlevel:=abs(slide[wchannel].Position);
       for i:=0 to Nofsamples-1 do
       begin
          inc(levelhis[abs(wavdata[i])]);
          if abs(wavdata[i])> testlevel then
          begin
            inc(abovelevel);
          end;
       end;
       if nofsamples>0 then ratio:=abovelevel/Nofsamples else ratio:=0;
       label1.caption:=floattostrf((100*ratio),ffgeneral,3,1);
       label2.caption:=inttostr(abs(testlevel));
       {
       with form15 do
       begin
          rfjchart1.start:=0;
          rfjchart1.eind:=32768;
          rfjchart1.buffered:=true;
          rfjchart1.trace[1].buffersize:=0;
          rfjchart1.traces:=1;
          rfjchart1.drawmode:=dmline;
          rfjchart1.setuptraces;
          rfjchart1.drawaxes;
          rfjchart1.addstart(1,1,levelhis[0]);
          for i:=1 to high(levelhis) do
          begin
              rfjchart1.addpoint(1,i,levelhis[i]);
          end;
          rfjchart1.autoscale(1);
          show;
       end;
       }
end;

procedure Tform1.count2;
var i:integer;
    over,under:boolean;
begin
       memo1.Lines.Add('count2 '+DateTimeToStr(Now));

       runningavgcount:=round(rxspinedit7.value);
       abovelevel:=0;
       count2peak:=false;
       if envelope(wavdata[0])> abs(scrollbar5.Position) then count2over:=true else count2under:=true;
       for i:=1 to Nofsamples-1 do
       begin
          if (abs(envelope(wavdata[i]))> abs(scrollbar5.Position)) then over:=true;
          if (abs(envelope(wavdata[i]))< abs(scrollbar5.Position)-50) then over:=false;
          if count2peak and not over then
          begin
             inc(abovelevel);
             count2peak:=false;
          end;
          if not count2peak and over then count2peak:=true;
       end;
       if nofsamples>0 then ratio:=(abovelevel/rfjchart2.eind) else ratio:=0;
       label1.caption:=floattostr(ratio);
       label2.caption:=inttostr(-scrollbar5.Position);
end;



procedure TForm1.RxSpinEdit3Change(Sender: TObject);
begin
 recalcsonogram:=true;
 if rxspinedit3.value>0 then StartHPfilter;
end;

procedure TForm1.RxSpinEdit2Change(Sender: TObject);
begin
  recalcsonogram:=true;
  if not odd(trunc(rxspinedit2.value)) then rxspinedit2.value:=rxspinedit2.Value+1;
  if rxspinedit1.value>0 then StartHPfilter;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 Stop:=true;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 //panel2.height:=advspreadgrid1.height+10;
 rxgifanimator4.Width:=Toolbar1.Width-toolbutton1.Left-5;
 if rxgifanimator4.Width > 400 then rxgifanimator4.Width:=400;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
   advspreadgrid1.SortSettings.Column:=1;
   advspreadgrid1.SortSettings.Direction:=sdDescending;
   advspreadgrid1.Qsort;
   if savedialog1.execute then advspreadgrid1.SaveToCSV(check_extension(Savedialog1.filename,'.CSV'));
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
     if checkbox4.Checked then zip:=true else zip:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
    dir:string[255];
    bufsize:cardinal;
begin
   //if not DirectoryExists('c:\temp') then
   // if not CreateDir('C:\temp') then
   // begin
   //   raise Exception.Create('Cannot create c:\temp. Program will Exit');
   //   application.Terminate;
   // end;
   animator:=rxgifanimator3;
   pageprint:=0;
   lockupdate:=false;
   rfjchart2.chart.Width:=tabsheet2.Width-15;
   rfjchart2.chart.height:=tabsheet2.height;
   rfjchart2.DoScroll:=false;
   rfjchart2.chart.scalemode:=smstretch;
   rfjchart2.backcolor:=clwhite;
   rfjchart2.setmemsize(1,0);
   rfjchart2.traces:=2;
   rfjchart2.trace[1].pen.color:=clblack;
   rfjchart2.trace[1].xaxispen.color:=clblack;
   rfjchart2.trace[1].yaxispen.color:=clblack;
   rfjchart2.trace[1].yaxislegend:='';
   rfjchart2.trace[2].yaxislegend:='';
   rfjchart2.drawaxes;
   rfjchart2.update;

   //for i:=1 to 5 do color_calibrate1.RGBtable[i]:=rgb(0,0,0);
   color_calibrate2.ColorTable:=4;
   color_calibrate2.Minvalue:=0;
   color_calibrate2.Maxvalue:=1024;
   combobox2.ItemIndex:=1;
   fileread:=false;
   env_calc:=false;
   fbmp2:=Tbitmap32.create;
   rate:=44052;

   //panel2.ManualFloat(rect(0,0,500,200));
   //panel2.Hide;
   //panel2.ManualDock(Panel15);
   //panel8.ManualFloat(rect(0,0,panel8.width,panel8.height+5));
   //panel8.ManualDock(Panel3);
   //panel3.Width:=1;
   //panel8.Hide;
   //panel11.ManualFloat(rect(0,0,200,400));
   //panel11.ManualDock(Panel12);
   //pagecontrol2.ActivePage:=Tabsheet4;

   advspreadgrid1.ColWidths[1]:=40;



   pagecontrol1.Pages[0].tabVisible:=false;
   pagecontrol1.Pages[2].tabVisible:=false;
   pagecontrol1.Pages[3].tabVisible:=checkbox29.Checked;
   pagecontrol1.Pages[4].tabVisible:=false;
   pagecontrol1.Pages[5].tabVisible:=false;
   pagecontrol1.Pages[7].tabVisible:=false;
   pagecontrol1.Pages[8].tabVisible:=false;

   pagecontrol3.Pages[6].tabVisible:=FALSE;

   toolwindow972.hide;
   toolwindow976.hide;
   toolwindow978.hide;
   toolwindow9712.hide;
   toolwindow9713.hide;
   toolwindow9715.hide;
   channelcount:=0;
   if checkbox23.Checked then
    begin
           inc(channelcount);
           wchannel:=channelcount;
    end;
    if checkbox5.Checked then
    begin
           inc(channelcount);
           schannel:=channelcount;
    end;
    if checkbox36.Checked then
    begin
           inc(channelcount);
           echannel:=channelcount;
    end;
    if checkbox16.Checked then
    begin
           inc(channelcount);
           gchannel:=channelcount;
    end;
    slideposition[1]:=0;
    slideposition[2]:=32767;
    slideposition[3]:=255;
    slideposition[4]:=25;
    slideposition[5]:=4750;
    slideposition[6]:=5000;
    recalcsonogram:=true;
    statusbar1.Show;
    //L2 := TRotLayer.Create(ImgView321.Layers);
    //L2.Bitmap := TBitmap32.Create;
    //L1 := TRotLayer.Create(ImgView321.Layers);
    //L1.Bitmap := TBitmap32.Create;
    dobitmapmove:=false;
    advstringgrid2.ColWidths[0]:=75;
    advstringgrid2.ColWidths[1]:=100;
    advstringgrid2.ColWidths[2]:=75;
    advstringgrid2.ColWidths[3]:=50;
    advstringgrid2.ColWidths[4]:=50;
    panel22.hide;
    splitter2.Hide;
    panel21.Align:=alclient;
    lockupdate:=true;
    label47.caption:='= '+floattostrf(rxspinedit4.value*(1000/rate),ffgeneral,2,2)+' msec';
    rate:=44052;
    StartHPfilter;
    showfilterkar;
    adjustTime:=true;
    GetDir(0,dir);
    programhome:=dir;
    pagecontrol1.Pages[6].tabVisible:=false;
    PNG := TPNGObject.Create;
    save_db:=false;
    save_bin:=false;
    processing:=false;
    Undolevel:=0;
    mouseisdown:=false;
    firstshow:=true;
    idbbmp:=Tbitmap32.create;
    idbbmp.StretchFilter:=sfnearest;
    imagefileisopen:=false;
    for i:=0 to 255 do greyscale[i]:=gray32(i);
    for i:=0 to maxclusters do showbmp[i]:=Tbitmap32.Create;
    loading_db:=false;
    loading_dat:=false;
    movie:=false;
end;


procedure Tform1.sonogram2;
var i,j,k:integer;
    windowlength:integer;
    overlap:integer;
    windowpower:integer;
    maxfreq:double;
    cols,rows:integer;
    pixel2time2:double;
    pixel2freq:double;
    first,last:integer;
    pointer:integer;
    maxpower:double;
    a,b:double;
    scale:integer;
    testgrey:double;
    windowmode:integer;
    fftcolor:Tcolor32;
    x,y:integer;
    rowgrid,colgrid:integer;
    gridcounter:integer;
    gridsize:integer;
    colduration,coltime:double;
    temp_bmp:Tbitmap;
    temp_bmp32:Tbitmap32;
    starttime,eindtime:double;
    result:boolean;
    t1,t2,freq:int64;
    elapsed:integer;
    sonogramstart,sonogrameind:integer;
    localshow:boolean;
    updater:integer;
    overlapsamples:integer;
    pad:integer;
    resolution:integer;
    nofcols:integer;
    startcol,eindcol:integer;
    testlength:double;
    testlength2:double;
    fbmp3,fbmp4:Tbitmap32;
    dstcolor,srccolor,difcolor:integer;
    offset:double;
    power2:double;
    cc,rc:integer;
    powr:integer;
    temp:integer;
    srcrect,dstrect:Trect;
    xmag:double;
    dstx:integer;
    background:integer;
    displaycols:integer;
    checkstate:boolean;
    dst_x,dst_y,dst_width,dst_height:integer;
    ytable:array[0..2047] of integer;
    testpower:double ;
begin
 updater:=0;
 statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
 if checkbox28.Checked then rxgifanimator4.show;
 queryperformancecounter(T1);

 //for i:=1 to 256 do color_calibrate1.RGBtable[i]:=0;
 if (nofsamples>0) then
 begin
  queryperformancecounter(T1);
  //
  windowlength:=strtoint(combobox1.Items.strings[combobox1.ItemIndex]);
  form1.caption:=inttostr(windowlength);
  case windowlength of
        16:windowpower:=4;
        32:windowpower:=5;
        64:windowpower:=6;
        128:windowpower:=7;
        256:windowpower:=8;
        512:windowpower:=9;
        1024:windowpower:=10;
        2048:windowpower:=11;
        4096:windowpower:=12;
  end;
  //
  maxpower:=(scrollbar6.max-scrollbar6.position)/10;//trunc(rxspinedit1.value);;
  if pagecontrol1.ActivePage=Tabsheet2 then
  begin
    maxpower:=(slide2[schannel].max-slide2[schannel].position)/10;//trunc(rxspinedit1.value);;
    if checkbox51.Checked then maxpower:=1;
  end;
  //
  maxfreq:=(rate div 2)/trunc(rxspinedit21.value)  ;//rxspinedit11.value;
  rows:=round((windowlength div 2)/maxfreq);
  //
  overlap:=0;
  //
  if checkbox25.Checked then
     resolution:=trunc(rxspinedit4.value)
  else
     resolution:=windowlength;
  //
  if (resolution>windowlength) or (overlap<0) then
  begin
      showmessage('Impossible Time Resolution!');
      checkbox25.checked :=false;
      resolution:=windowlength;
  end;
  //
  overlap:=windowlength-resolution;
  //
  sonogramstart:=startsample;
  sonogrameind:=eindsample;
  testlength:=(sonogrameind-sonogramstart)/windowlength;
  testlength2:=(sonogrameind-sonogramstart)/resolution;
  cols:=round((sonogrameind-sonogramstart)/resolution);
  displaycols:=rfjchart2.trace[1].yright-rfjchart2.trace[1].yleft;
  label51.caption:=floattostrf(resolution*(1000/rate),ffgeneral,2,2)+' msec' ;
  if checkbox54.Checked and (cols> displaycols) then
  begin
    cols:=displaycols;
    resolution:=round((sonogrameind-sonogramstart)/cols);
    //checkstate:=checkbox12.Checked;
    //checkbox12.Checked:=false;
   label51.caption:=floattostrf(resolution*(1000/rate),ffgeneral,2,2)+' msec'
    //checkbox12.Checked:=checkstate;
  end;
  //
  fbmp2.SetSize(cols,rows);
  fbmp2.Clear(clwhite32);
  //pixel2freq:=(rate div 2)/(maxfreq*rfjchart1.height);
  pixel2freq:=1;
  windowmode:=combobox2.ItemIndex;
  first:=1;
  last:=cols;
  for j:= first to last do
   begin
        {
        for k:=0 to windowlength-1 do
        begin
            //pointer:=((k)+(j-1)*(windowlength-overlap));
            pointer:=-(windowlength div 2)+sonogramstart+k+((j-1)*resolution);
            if (pointer<nofsamples) and (pointer>0) then
               slice[k]:=wavdata[pointer]
            else
               slice[k]:=0;
        end;
        Getspectrum(combobox2.ItemIndex,Windowlength,Power);
        }
        for k:=0 to windowlength-1 do
        begin
            //pointer:=((k)+(j-1)*(windowlength-overlap));
            pointer:=-(windowlength div 2)+sonogramstart+k+((j-1)*resolution);
            if (pointer<nofsamples) and (pointer>0) then
               islice[k]:=wavdata[pointer]
            else
               islice[k]:=0;
        end;
        GetspectrumI(combobox2.ItemIndex,Windowlength,Power);

        for i:=0 to (windowlength div 2)-2 do
        begin
             //TestGrey:=colors.Maxvalue-(maxpower*power[i]);
             //if testgrey<=0 then fftcolor:=0 else fftcolor:=colors.Val2Color(round(testgrey));
             //fbmp2.pixels[j-first,rows-i]:=fftcolor;
             testpower:=(power[i]-meanpower[i]);
             if testpower<0 then testpower:=0;
             testgrey:=255-maxpower*testpower;
             if testgrey<0 then testgrey:=0;
             fbmp2.pixels[j-first,rows-i]:=gray32(form1.sonogram_lut[trunc(testgrey)]);
        end;
  end;
 end;

 //rfjchart2.trace[schannel].background.SetSize(fbmp2.Width,fbmp2.Height);
 //MedFilter(fbmp2,rfjchart2.trace[schannel].background,5);

 rfjchart2.trace[schannel].background.Assign(fbmp2);

 if checkbox6.Checked then Form8.LUTControl1Change(Self);

 //special sonogram fit for large->small bitmaps
 dst_width:=rfjchart2.trace[schannel].yright-rfjchart2.trace[schannel].yleft;
 dst_height:=rfjchart2.trace[schannel].xbottom-rfjchart2.trace[schannel].xtop;
 if checkbox55.checked and (dst_width<fbmp2.Width) and (dst_height<fbmp2.height) then
 begin
    fbmp3:=Tbitmap32.create;
    fbmp3.SetSize(dst_width,dst_height);
    fbmp3.Clear(clwhite32);
    for y:=0 to fbmp2.height-1 do ytable[y]:=round(y*(dst_height/fbmp2.height));
    for x:=0 to fbmp2.Width-1 do
    begin
     dst_x:=round(x*(dst_width/fbmp2.Width));
     for y:=0 to fbmp2.height-1 do
      begin
         dst_y:=ytable[y];
         dstcolor:=REDCOMPONENT(fbmp3.Pixels[dst_x,dst_y]);
         srccolor:=REDCOMPONENT(fbmp2.PixelS[x,y]);
         if srccolor<255 then
           if srccolor<dstcolor then
             fbmp3.SetPixelT(dst_x,dst_y,gray32(srccolor,$FF));
      end;
    end;
    if checkbox51.checked then
    begin
     fbmp4:=Tbitmap32.create;
     fbmp4.SetSize(fbmp3.Width,fbmp3.height);
     power2:=0.1*(slide2[schannel].max-slide2[schannel].position);
     background:=trunc(rxspinedit38.value);
     for x:=0 to fbmp3.Width-2 do
       for y:=0 to fbmp3.height-2 do
       begin
         difcolor:=round(power2*(REDCOMPONENT(fbmp3.PixelS[x,y])-redcomponent(fbmp3.PixelS[x,y+1])));
         difcolor:=background-difcolor;
         if difcolor>255 then difcolor:=255;
         if difcolor<0 then difcolor:=0;
         fbmp4.SetPixelT(x,y,gray32(difcolor,$FF));
       end;
    end;
    //fbmp2.assign(fbmp3);
    if checkbox51.checked then
       begin
        rfjchart2.trace[schannel].background.Assign(fbmp4);
        fbmp4.free;
       end
    else
        rfjchart2.trace[schannel].background.Assign(fbmp3);

    fbmp3.free;
 end;

 if checkbox51.checked then
  if (not checkbox55.checked) or (checkbox55.checked and ((dst_width>=fbmp2.Width) or (dst_height>=fbmp2.height))) then
  begin
   fbmp4:=Tbitmap32.create;
   fbmp4.SetSize(fbmp2.Width,fbmp2.height);
   power2:=0.1*(slide2[schannel].max-slide2[schannel].position);
   background:=trunc(rxspinedit38.value);
   for x:=0 to fbmp2.Width-2 do
     for y:=0 to fbmp2.height-2 do
      begin
         difcolor:=round(power2*(REDCOMPONENT(fbmp2.PixelS[x,y])-redcomponent(fbmp2.PixelS[x,y+1])));
         difcolor:=background-difcolor;
         if difcolor>255 then difcolor:=255;
         if difcolor<0 then difcolor:=0;
         fbmp4.SetPixelT(x,y,gray32(difcolor,$FF));
      end;
      //fbmp2.assign(fbmp4);
      rfjchart2.trace[schannel].background.Assign(fbmp4);
      fbmp4.free;
  end;



 recalcsonogram:=false;
 if checkbox29.Checked then
 begin
   queryperformancecounter(T2);
   queryperformancefrequency(freq);
   //elapsed:=round((rate/(eindsample-startsample))*1000*(t2-T1)/freq);
   elapsed:=round(1000*(t2-T1)/freq);
   memo1.Lines.Add(inttostr(elapsed)+' sonogram '+DateTimeToStr(Now));
 end;

 statusbar1.Panels[4].Text:='';statusbar1.Update;
 rxgifanimator4.hide;
end;


procedure Tform1.aho_sonogram2;
var i,j,k:integer;
    windowlength:integer;
    overlap:integer;
    windowpower:integer;
    maxfreq:double;
    cols,rows:integer;
    pixel2time2:double;
    pixel2freq:double;
    first,last:integer;
    pointer:integer;
    maxpower:double;
    a,b:double;
    scale:integer;
    testgrey:double;
    windowmode:integer;
    fftcolor:Tcolor32;
    x,y:integer;
    rowgrid,colgrid:integer;
    gridcounter:integer;
    gridsize:integer;
    colduration,coltime:double;
    temp_bmp:Tbitmap;
    temp_bmp32:Tbitmap32;
    starttime,eindtime:double;
    result:boolean;
    t1,t2,freq:int64;
    elapsed:integer;
    sonogramstart,sonogrameind:integer;
    localshow:boolean;
    updater:integer;
    overlapsamples:integer;
    pad:integer;
    resolution:integer;
    nofcols:integer;
    startcol,eindcol:integer;
    testlength:double;
    testlenght2:double;
    offset:double;
    fbmp3,fbmp4:Tbitmap32;
    dstcolor,srccolor,difcolor:integer;
    power2:double;
    background:integer;
    displaycols:integer;
    checkstate:boolean;
    dst_x,dst_y,dst_width,dst_height:integer;
    testpower:double;
begin
 updater:=0;
 statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
 if checkbox28.Checked then rxgifanimator4.show;
 queryperformancecounter(T1);

 //for i:=1 to 256 do color_calibrate1.RGBtable[i]:=0;
 if (nofsamples>0) then
 begin
  queryperformancecounter(T1);
  //
  windowlength:=trunc(rxspinedit37.value);
  maxpower:=scrollbar6.max-scrollbar6.position;//trunc(rxspinedit1.value);;
  if pagecontrol1.ActivePage=Tabsheet2 then
  begin
    maxpower:=(slide2[schannel].max-slide2[schannel].position)/10;//trunc(rxspinedit1.value);;
    if checkbox51.Checked then maxpower:=1;
  end;
  //
  maxfreq:=(rate div 2)/trunc(rxspinedit21.value)  ;//rxspinedit11.value;
  rows:=round((windowlength div 2)/maxfreq);
  //
  overlap:=0;
  //
  if checkbox25.Checked then
     resolution:=trunc(rxspinedit4.value)
  else
     resolution:=windowlength;
  //
  if (resolution>windowlength) or (overlap<0) then
  begin
      showmessage('Impossible Time Resolution!');
      checkbox25.checked :=false;
      resolution:=windowlength;
  end;
  //
  overlap:=windowlength-resolution;
  //
  sonogramstart:=startsample;
  sonogrameind:=eindsample;
  testlength:=(sonogrameind-sonogramstart)/windowlength;
  //form1.caption:=floattostr(testlength);
  testlenght2:=round(testlength)*windowlength;
  testlength:=(sonogrameind-sonogramstart)/resolution;
  //form1.caption:=floattostr(testlength);
  //
  cols:=round((sonogrameind-sonogramstart)/resolution);
  label51.caption:=floattostrf(resolution*(1000/rate),ffgeneral,2,2)+' msec';
  displaycols:=rfjchart2.trace[1].yright-rfjchart2.trace[1].yleft;
  if checkbox54.Checked and (cols> displaycols) then
  begin
    cols:=displaycols;
    resolution:=round((sonogrameind-sonogramstart)/cols);
    //checkstate:=checkbox12.Checked;
    //checkbox12.Checked:=false;
   label51.caption:=floattostrf(resolution*(1000/rate),ffgeneral,2,2)+' msec';
    //checkbox12.Checked:=checkstate;
  end;
  //
  fbmp2.SetSize(cols,rows);
  fbmp2.Clear(clwhite32);
  //pixel2freq:=(rate div 2)/(maxfreq*rfjchart1.height);
  pixel2freq:=1;
  windowmode:=combobox2.ItemIndex;
  first:=1;
  last:=cols;

  for j:= first to last do
   begin
        {
        inc(updater);
        if updater>400 then
        begin
            //application.processmessages;
            rxgifanimator4.frameindex:=rxgifanimator4.FrameIndex+1;
            if rxgifanimator4.FrameIndex>rxgifanimator4.Image.Count then
            begin
             rxgifanimator4.FrameIndex:=0;
            end;
            rxgifanimator4.Repaint;
            updater:=0;
        end;
        }
        for k:=0 to windowlength-1 do
        begin
            //pointer:=((k)+(j-1)*(windowlength-overlap));
            pointer:=-(windowlength div 2)+sonogramstart+k+((j-1)*resolution);
            if (pointer<nofsamples) and (pointer>0) then
              slice[k]:=wavdata[pointer]
            else
              slice[k]:=0;
        end;
        AhoSpectrum(combobox6.ItemIndex,Windowlength,Power);
        for i:=0 to (windowlength div 2)-2 do
        begin
             //TestGrey:=colors.Maxvalue-(maxpower*power[i]/2);
             //if testgrey<=0 then fftcolor:=0 else fftcolor:=colors.Val2Color(round(testgrey));
             //fbmp2.pixels[j-first,rows-i]:=fftcolor;
             testpower:=(power[i]-meanpower[i]);
             if testpower<0 then testpower:=0;
             testgrey:=255-maxpower*testpower*0.45;
             if testgrey<0 then testgrey:=0;
             fbmp2.pixels[j-first,rows-i]:=gray32(sonogram_lut[trunc(testgrey)]);
        end;
  end;
 end;

  rfjchart2.trace[schannel].background.Assign(fbmp2);

 //special sonogram fit
 dst_width:=rfjchart2.trace[schannel].yright-rfjchart2.trace[schannel].yleft;
 dst_height:=rfjchart2.trace[schannel].xbottom-rfjchart2.trace[schannel].xtop;
 if checkbox55.checked and (dst_width<fbmp2.Width) and (dst_height<fbmp2.height) then
 begin
    fbmp3:=Tbitmap32.create;
    fbmp3.SetSize(dst_width,dst_height);
    fbmp3.Clear(clwhite32);
    for x:=0 to fbmp2.Width-1 do
    begin
     dst_x:=round(x*(dst_width/fbmp2.Width));
     for y:=0 to fbmp2.height-1 do
      begin
         dst_y:=round(y*(dst_height/fbmp2.height));
         dstcolor:=REDCOMPONENT(fbmp3.Pixels[dst_x,dst_y]);
         srccolor:=REDCOMPONENT(fbmp2.PixelS[x,y]);
         if srccolor<255 then
           if srccolor<dstcolor then
             fbmp3.SetPixelT(dst_x,dst_y,gray32(srccolor,$FF));
      end;
    end;
    if checkbox51.checked then
    begin
     fbmp4:=Tbitmap32.create;
     fbmp4.SetSize(fbmp3.Width,fbmp3.height);
     power2:=0.1*(slide2[schannel].max-slide2[schannel].position);
     background:=trunc(rxspinedit38.value);
     for x:=0 to fbmp3.Width-2 do
       for y:=0 to fbmp3.height-2 do
       begin
         difcolor:=round(power2*(REDCOMPONENT(fbmp3.PixelS[x,y])-redcomponent(fbmp3.PixelS[x,y+1])));
         difcolor:=background-difcolor;
         if difcolor>255 then difcolor:=255;
         if difcolor<0 then difcolor:=0;
         fbmp4.SetPixelT(x,y,gray32(difcolor,$FF));
       end;

    end;
    //fbmp2.assign(fbmp3);
    if checkbox51.checked then
       begin
        rfjchart2.trace[schannel].background.Assign(fbmp4);
        fbmp4.free;
       end
    else
        rfjchart2.trace[schannel].background.Assign(fbmp3);

    fbmp3.free;
 end;

 if checkbox51.checked then
  if (not checkbox55.checked) or (checkbox55.checked and ((dst_width>=fbmp2.Width) or (dst_height>=fbmp2.height))) then
  begin
   fbmp4:=Tbitmap32.create;
   fbmp4.SetSize(fbmp2.Width,fbmp2.height);
   power2:=0.1*(slide2[schannel].max-slide2[schannel].position);
   background:=trunc(rxspinedit38.value);
   for x:=0 to fbmp2.Width-2 do
     for y:=0 to fbmp2.height-2 do
      begin
         difcolor:=round(power2*(REDCOMPONENT(fbmp2.PixelS[x,y])-redcomponent(fbmp2.PixelS[x,y+1])));
         difcolor:=background-difcolor;
         if difcolor>255 then difcolor:=255;
         if difcolor<0 then difcolor:=0;
         fbmp4.SetPixelT(x,y,gray32(difcolor,$FF));
      end;
   //fbmp2.assign(fbmp4);
   rfjchart2.trace[schannel].background.Assign(fbmp4);
   fbmp4.free;
  end;

 recalcsonogram:=false;
 if checkbox29.Checked then
 begin
   queryperformancecounter(T2);
   queryperformancefrequency(freq);
   //elapsed:=round((rate/(eindsample-startsample))*1000*(t2-T1)/freq);
   elapsed:=round(1000*(t2-T1)/freq);
   memo1.Lines.Add(inttostr(elapsed)+' sonogram '+DateTimeToStr(Now));
 end;
 statusbar1.Panels[4].Text:='';statusbar1.Update;
 rxgifanimator4.hide;
end;


function TForm1.AudioOut1FillBuffer(Buffer: PAnsiChar;
  var Size: Integer): Boolean;
Var
  NW, i, ts : Integer;
  P : ^SmallInt;
  //outbuffersize:integer;
  signal:integer;
  durationsample:double;
  time:integer;
begin
   time:=0;
   NW := audioout1.BufferSize div 2;
   //durationsample:=round((eindsample-startsample)/audioout1.framerate);
   //signal:=trunc(rxspinedit1.value);

   //If (AudioOut1.QueuedBuffers >=  TotalBuffers) and (TotalBuffers > 0) Then
   //  Begin
   //   Result := FALSE;
   //   Exit;
   //  End;

   if (Time>=(durationsample-nw)) then
   Begin
       Result := FALSE;
       Exit;
   End;

   P := Pointer(Buffer);
   //ts := NW*AudioOut1.FilledBuffers;
   For i := 0 to NW-1 Do
   Begin
      inc(time);
      P^ := outbuffer[time];
      Inc(P);
   End;
   Result := True;
end;


procedure TForm1.ScrollBar4Change(Sender: TObject);
var m:tmouse;
begin
// if checkbox12.checked and not (m.isdragging) then sonogram;
// scrollbar6.Position:=scrollbar4.position;

end;

procedure TForm1.RxSpinEdit4Change(Sender: TObject);
begin
 label47.caption:='= '+floattostrf(rxspinedit4.value*(1000/rate),ffgeneral,2,2)+' msec';
 if checkbox25.Checked and checkbox12.checked then
 begin
   recalcsonogram:=true;
   if checkbox46.checked then  env_calc:=false;
   chart2;
 end;
end;

procedure TForm1.RxSpinEdit5Change(Sender: TObject);
begin
  imgview321.Scale:=RXSPINEDIT5.VALUE;
end;

procedure TForm1.ScrollBar5Change(Sender: TObject);
begin
    //if not lefmousebuttonisdown then
    begin
       //chart2;
       //count2;
    end;
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
chart2;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
   clustering:=false;
   if fileread and (pagecontrol1.activepage=tabsheet2) then chart2;

   //if (pagecontrol1.activepage=tabsheet19)then htmlLite1.LoadFromFile(programhome+'\help\main_map.htm');

   //if (pagecontrol1.activepage=tabsheet20)then
   //begin
   //    rfjchart9.Height:=pagecontrol1.ActivePage.Height div 2;
   //    rfjchart8.Height:=rfjchart9.Height;
   //    application.processmessages;
   //end;

   //if (pagecontrol1.activepage=tabsheet19)then
   //reads in procedure ThtmlLite.DoLogic
   //  if opendialog1.Execute then
   //          htmllite1.LoadImageFile(opendialog1.FileName);
   //if (pagecontrol1.activepage=tabsheet19)then htmlLite1.LoadFromFile('d:\help.html');

   if (pagecontrol1.activepage=tabsheet20)then clustering:=true;
end;

procedure TForm1.RxSpinEdit7Change(Sender: TObject);
begin
    if checkbox12.checked then
    begin
     env_calc:=false;
     chart2;
    end;
end;

procedure TForm1.RxSpinEdit8Change(Sender: TObject);
begin
   if checkbox12.checked then
   begin
     env_calc:=false;
     if pagecontrol1.ActivePage=tabsheet2 then chart2;
   end;
end;

procedure TForm1.CheckBox100Click(Sender: TObject);
begin
 if checkbox100.Checked then image321.scalemode:=smstretch else image321.scalemode:=smnormal;
 
end;

procedure TForm1.CheckBox10Click(Sender: TObject);
var checkstate:boolean;
    realfilename:string;
begin
 if fileread then
 begin
   checkstate:=checkbox26.Checked;
   checkbox26.Checked:=true;
   fileread:=false;
   env_calc:=false;
   recalcsonogram:=true;
   realfilename:=currentfile;
   currentfile:=opendialog1.FileName;
   if not fileread then showwave;
   //StartHPfilter;
   if checkbox10.Checked then filter;
   currentfile:=realfilename;
    begin
           chart;
           if (pagecontrol1.ActivePage=tabsheet2) and checkbox9.checked then count2;
           if (pagecontrol1.ActivePage=tabsheet1) and checkbox8.checked then count;
           application.ProcessMessages;
           if checkbox7.Checked then if checkbox47.Checked then aho_sonogram2 else sonogram2;
    end;
   checkbox26.Checked:=checkstate;
 end;
end;

procedure Tform1.showfilterkar;
var relfreq:integer;
    j:integer;
    OutSamp,MaxSamp,MinSamp:smallint;
    //Tonestate:TNSPSToneState;
    Tonestate:TNSPWToneState;
    sample:double;
    samps:array[0..5000] of smallint;
    tempvar:integer;
    TempSamp:double;
    temp:smallint;
    testsample:smallint;
    scale:integer;
begin
  for j:=0 to 5000 do samps[j]:=0;
  StartHPfilterW;
  scale:=0;
  rfjchart4.traces:=1;
  rfjchart4.trace[1].ygmin:=0;
  rfjchart4.trace[1].ygmax:=1100;
  rfjchart4.backcolor:=clwhite;
  rfjchart4.trace[1].pen.color:=clblack;
  rfjchart4.trace[1].xaxispen.color:=clblack;
  rfjchart4.trace[1].yaxispen.color:=clblack;
  rfjchart4.trace[1].clipy:=true;
  rfjchart4.start:=0;
  rfjchart4.eind:=trunc(rxspinedit9.value);
  rfjchart4.trace[1].ymarginleft:=40;
  rfjchart4.trace[1].ymarginright:=10;
  rfjchart4.trace[1].yaxislegend:='';
  rfjchart4.setuptraces;
  rfjchart4.drawaxes;
  rfjchart4.reset;
  rfjchart4.buffered:=true;
  if rate>0 then
   for relfreq:=1 to trunc(10000*(rxspinedit9.value/rate)) do
   begin
     MinSamp:=1000;MaxSamp:=-1000;
     nspwToneInit(relfreq/10000,0.5*pi,1000,ToneState);
     nspwbTone(Tonestate,@Samps,5000);
     tempvar:=4999;
     case relfreq of
       1..10:tempvar:=4999;
       11..4999:tempvar:=1000;
     end;
     for j:=1 to tempvar do
     begin
        outsamp:=round(nspwFir(HPchannelState[1],samps[j],NSP_NO_SCALE,scale));
        if j >800 then
        begin
            if OutSamp>MaxSamp then MaxSamp:=OutSamp;
            if OutSamp<MinSamp then MinSamp:=OutSamp;
        end;
     end;
     if (rate*relfreq/10000)< rfjchart4.eind then rfjchart4.addpoint(1,rate*relfreq/10000,round((MaxSamp-MinSamp)/2));
  end;
  rfjchart4.setxmark(1,rxspinedit3.value);
  rfjchart4.update;
  rfjchart4.traces:=0;
end;


procedure TForm1.Button8Click(Sender: TObject);
var nofunderscores:integer;
    i:integer;
    timestring:string;
begin
 //extract real time from filename
 // 1) count then numbr od underscores in the name
 nofunderscores:=z_ItemCCount(currentfile,'_')-1;
 timestring:=z_ItemCGetFmTo(currentfile,1,1,'_');
 Hrs:=z_SMiddle(Timestring,1,2);
 Min:=z_SMiddle(Timestring,3,2);
 Sec:=z_SMiddle(Timestring,5,2);
 timestring:=z_ItemCGetFmTo(currentfile,2,2,'_');
 Day:=z_SMiddle(Timestring,1,2);
 Month:=z_SMiddle(Timestring,3,2);
 Year:=z_SMiddle(Timestring,5,2);
end;

{
procedure TForm1.rfjChart1click(Sender: TObject);
var mx,my:integer;
    m:tmouse;
    trace:integer;
begin
    mx:=m.CursorPos.X;
    my:=m.CursorPos.X;
    if checkbox37.Checked then form3.show;
    if points_at_trace=1 then
    begin
     if form3.CheckBox2.checked then
     begin
       rfjchart1.marksize:=trunc(rxspinedit14.value);
       rfjchart1.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart1.update;
     end;
     if form3.CheckBox1.Checked then
     begin
      advstringgrid2.Cells[form3.currentcol,form3.currentrow]:=currentfile;
      advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:=tabsheet1.Caption;
      advstringgrid2.Cells[form3.currentcol+2,form3.currentrow]:=form3.Label2.caption;
      advstringgrid2.Cells[form3.currentcol+3,form3.currentrow]:=form3.Label4.caption;
      inc(form3.currentrow);
      if form3.currentrow>advstringgrid2.rowcount then advstringgrid2.rowcount:=advstringgrid2.rowcount+1;
      advstringgrid2.row:=advstringgrid2.rowcount-1;
      advstringgrid2.Col:=4;
     end;
    end;
    if points_at_trace=2 then
    begin
     if form3.CheckBox2.checked then
     begin
       rfjchart1.marksize:=trunc(rxspinedit14.value);
       rfjchart1.setmark(2,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart1.update;
     end;
     if form3.CheckBox1.Checked then
     begin
      advstringgrid2.Cells[form3.currentcol,form3.currentrow]:=currentfile;
      advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='SONOGRAM';
      advstringgrid2.Cells[form3.currentcol+2,form3.currentrow]:=form3.Label2.caption;
      advstringgrid2.Cells[form3.currentcol+3,form3.currentrow]:=form3.Label4.caption;
      inc(form3.currentrow);
      if form3.currentrow>advstringgrid2.rowcount then advstringgrid2.rowcount:=advstringgrid2.rowcount+1;
      advstringgrid2.row:=advstringgrid2.rowcount-1;
      advstringgrid2.Col:=4;
     end;
    end;
end;
}

procedure TForm1.Button10Click(Sender: TObject);
var temp_bmp:Tbitmap;
    checkstate,checkstate2:boolean;
begin
 checkstate:=checkbox54.Checked;
 checkstate2:=checkbox55.Checked;
 if checkbox54.Checked or checkbox55.checked then
 begin
   checkbox54.Checked:=false;
   checkbox55.Checked:=false;
   button14click(self);
   application.processmessages;
 end;
 if checkbox28.Checked then rxgifanimator4.show;
 statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
//////////////////////////////////////////////
 if pagecontrol1.ActivePage=Tabsheet2 then
   begin
    if printersetupdialog1.Execute then
    begin
     printer.orientation:=polandscape;
     printer.begindoc;
      rfjchart2.drawmode:=dmline;
      rfjchart2.printer_trace[1].clipy:=true;
      rfjchart2.printmag:=rxspinedit15.Value/100;
      rfjchart2.printeryoffset:=0;
      rfjchart2.printerxoffset:=0;
      rfjchart2.getprinterpar;
      rfjchart2.printerdrawaxes;
      rfjchart2.printerdrawbuffer;
     printer.enddoc;
    end;
   end;
 //////////////////////////////////////////////
  rxgifanimator4.hide;
  checkbox54.Checked:=checkstate;
  checkbox55.Checked:=checkstate2;
end;

procedure TForm1.RxSpinEdit11Change(Sender: TObject);
begin
  if checkbox47.Checked then aho_sonogram2 else sonogram2;
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
 //if checkbox7.Checked then if checkbox47.Checked then aho_sonogram else sonogram;;
end;

procedure TForm1.CheckBox13Click(Sender: TObject);
begin
   if checkbox13.checked then
   begin
     checkbox11.checked:=false;
     checkbox46.checked:=false;
     checkbox45.checked:=false;
     env_calc:=false;
     if pagecontrol1.ActivePage=tabsheet2 then chart2;
   end;
end;

procedure TForm1.RxSpinEdit12Change(Sender: TObject);
begin
// if rxspinedit12.value>=rxspinedit13.value then rxspinedit12.value:=0;
 Undolevel:=0;
 Button70.caption:='Un-edit '+inttostr(Undolevel);
 env_calc:=false;
 recalcsonogram:=true;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  if checkbox12.checked then  if checkbox47.Checked then aho_sonogram2 else sonogram2;
end;

procedure TForm1.ComboBox2Select(Sender: TObject);
begin
 if checkbox12.checked then if checkbox47.Checked then aho_sonogram2 else sonogram2;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
 checkbox54.Checked:=true;
 checkbox47.Checked:=false;
end;

{
procedure TForm1.rfjChart1resize(Sender: TObject);
begin
 //if checkbox29.Checked then
 begin
  rfjchart1.keepdata:=true;
  rfjchart1.setuptraces;
  rfjchart1.drawaxes;
  rfjchart1.drawbuffer;
  rfjchart1.update;
 end;
 //if not checkbox29.Checked then
 begin
   button14click(self);
 end;
  scrollbar6.height:=rfjchart1.Height div 2;
  color_calibrate2.height:=rfjchart1.Height div 2;

end;
}

procedure TForm1.rfjChart2resize(Sender: TObject);
begin
 rfjchart2.update;
 application.ProcessMessages;
 //if checkbox29.Checked then
 begin
  rfjchart2.keepdata:=true;
  rfjchart2.setuptraces;
  rfjchart2.drawaxes;
  rfjchart2.drawbuffer;
  rfjchart2.update;
 end;
 //if not checkbox29.Checked then
 //begin
 //   button14click(self);
 //end;
end;

procedure TForm1.rfjChart3resize(Sender: TObject);
begin
{
  rfjchart3.keepdata:=true;
  rfjchart3.setuptraces;
  rfjchart3.drawaxes;
  rfjchart3.drawbuffer;
  rfjchart3.update;
  }
end;

procedure TForm1.Color_calibrate1Click(Sender: TObject);
var i:integer;
    temp:smallint;
begin
{
    color_calibrate2.ColorTable:=color_calibrate2.ColorTable+1;
    if color_calibrate2.ColorTable=11 then color_calibrate2.ColorTable:=1;
    if color_calibrate2.ColorTable=9 then
    begin
     color_calibrate2.Minvalue:=0;
     color_calibrate2.Maxvalue:=1024;
     //for i:=1 to 5 do color_calibrate1.RGBtable[i]:=rgb(0,0,0);
    end;
    //sonogram;
    //schannel_leftscroll_change(self);
}
end;

procedure TForm1.CheckBox14Click(Sender: TObject);
var  temp_bmp:Tbitmap;
     bmp32:tbitmap32;
begin
{
 if checkbox14.Checked then
 begin
    bmp32:=tbitmap32.create;
    bmp32:=rfjchart1.trace[2].background;
    bmp32.SaveToFile('$$$.bmp');
    temp_bmp:=Tbitmap.Create;
    temp_bmp.LoadFromFile('$$$.bmp');
    contrast(temp_bmp,trunc(rxspinedit11.value));
    temp_bmp.SaveToFile('$$$.bmp');
    bmp32.LoadFromFile('$$$.bmp');
    rfjchart1.trace[1].background.assign(bmp32);
    rfjchart1.drawaxes;
    rfjchart1.update;
    bmp32.free;
    temp_bmp.Free;
 end;
 if not checkbox14.Checked then
 begin
    bmp32:=tbitmap32.create;
    bmp32.LoadFromFile('$$$_keep.bmp');
    rfjchart1.trace[2].background.assign(bmp32);
    rfjchart1.drawaxes;
    rfjchart1.update;
    bmp32.free;
 end;
}
end;

procedure TForm1.Button12Click(Sender: TObject);
var bmp32:tbitmap32;
begin
{
    bmp32:=tbitmap32.create;
    bmp32:=rfjchart1.trace[2].background;
    bmp32.SaveToFile('$$$_keep.bmp');
    bmp32.free;
}
end;

procedure TForm1.Button13Click(Sender: TObject);
var bmp32:tbitmap32;
begin
{
    bmp32:=tbitmap32.create;
    bmp32.LoadFromFile('$$$_keep.bmp');
    rfjchart1.trace[2].background.assign(bmp32);
    rfjchart1.drawaxes;
    rfjchart1.update;
    bmp32.free;
}
end;

procedure TForm1.rfjChart3mousedown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 //mousedownx:=x;
 //mousedowny:=y;
 //zoomymin:=rfjchart3.ypos2val(mouseupx,mouseupx);
 //if (x>rfjchart3.trace[1].yleft) and (x<rfjchart3.trace[1].yright) then spectrum(x,y);
end;

procedure TForm1.rfjChart5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
    form3.Label2.caption:=floattostrf(rfjchart5.xpos2val(x,y),fffixed,6,2);
    form3.Label4.caption:=floattostr(rfjchart5.ypos2val(x,y));
end;

procedure TForm1.rfjChart5resize(Sender: TObject);
begin
  rfjchart5.keepdata:=true;
  rfjchart5.backcolor:=clwhite;
  rfjchart5.trace[1].xaxispen.color:=clblack;
  rfjchart5.trace[1].yaxispen.color:=clblack;
  rfjchart5.trace[1].pen.color:=clblack;
  rfjchart5.setuptraces;
  rfjchart5.drawaxes;
  rfjchart5.drawbuffer;
  rfjchart5.update;
end;

procedure TForm1.rfjChart3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
    //form3.Label2.caption:=floattostrf(rfjchart3.xpos2val(x,y),fffixed,6,2);
    //form3.Label4.caption:=inttostr(rfjchart3.ypos2val(x,y));
    //if checkbox15.Checked then
    //    if (x>rfjchart3.trace[1].yleft) and (x<rfjchart3.trace[1].yright) then spectrum(x,y);
end;

procedure Tform1.spectrum(x,y:integer);
var sample:double;
    windowlength,maxpower,windowpower,windowmode,k,i,maxfreq,maxrows,rows:integer;
    bin2freq:double;
    maxy:integer;
    testval:double;
    spectrum_data:array of smallint;
    oldmaxy:double;
    xtime:double;
    spechis:array[1..100] of integer;
    spechisbin:integer;
    spechisbinsize:double;
    pdrempel,pdrempel2:integer;
    under,tracking:boolean;
    peak:double;
    peakat:integer;
    markcount:integer;
    pfreq:integer;
    med1,med2:array[0..4096] of integer;
    size:integer;
    omgeving:array[0..50] of integer;
    medianrun:integer;
    kp:integer;
    meanspect,summeanspect:double;
    meanrun:integer;
    env_start,env_eind:double;
    env_start_sample,env_eind_sample:integer;
    env_samples:integer;
    env_blocks:integer;
    env_power:array[0..2048] of double;
    env_slice:array[0..2048] of smallint;
    env_pointer:integer;
    j,w:integer;
    tempvar:smallint;
    temp:double;
    xoffset:integer;
    Timeoffset:double;
    T:Ttimestamp;
    allzero:boolean;
    env_size:integer;
    fft1_samples,fft1_start,fft1_eind,fft1_blocks:integer;
    fft2_samples,fft2_start,fft2_eind,fft2_blocks:integer;
    fft3_samples,fft3_start,fft3_eind,fft3_blocks:integer;
    fft4_samples,fft4_start,fft4_eind,fft4_blocks:integer;
    fft3_mid:integer;
    fft4_mid:integer;
    realsize,realsheetsize,sheetsize:integer;
    spectrumwritten:boolean;
    tbef,tref,taft:double;
    specdat:array[1..1] of specdata;
    specdatf:array[1..1] of specdataf;
    bwritten:integer;
    z:integer;
    acor:array[0..512] of double;
    amean,gmean,amean2,gmean2,mode,medianp:double;
    wiener,wiener2,sumspec:double;
    lnsumspec:double;
    pmax:double;
    sumwfreq:double;
    wfreq:double;
    syl_freq,localsum:double;
    syl_duration,syl_meanfreq,syl_meanfreqsd,syl_modefreq,syl_modefreqsd,syl_wiener,syl_wienersd:double;
    syl_median,syl_mediansd,syl_firstpeak,syl_firstpeaksd:double;
    data:pvector;
    blocks:integer;
    resolution:integer;
    mdata:pvector;
    mdata1,mdata2:array [0..4096] of double;
    firstpeakfound:boolean;
    firstpeaklevel:double;
    firstpeak:double;
    abovelevel,belowlevel:boolean;
    phis:array [1..1000] of double;
    ptemp:double;
    pbinsize,pbin:integer;
    N,Ubound,N2,Lbound:integer;
    wp:integer;
    zerocrossings:Integer;
    lookforbelowzero,lookforabovezero:Boolean;
    avgzerodistance:double;
    avgzerodistance_time,avgzerodistance_freq:Double;
    maxpospeak,maxpospeakat,maxnegpeak,maxnegpeakat,abswp:integer;
    p1,p2:SmallInt;
begin

 spectrumwritten:=false;

 spectrumwritten:=true;
 //form21.advspreadgrid1.Cells[2,form21.advspreadgrid1.rowcount-1]:='0000000';


 spectrumlastx:=x;
 spectrumlasty:=y;
 zeromemory(@Spechis,100*sizeof(integer));

 windowlength:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);
 xtime:=rfjchart2.xpos2val(x,y);
 //xtime:=strtofloat(form3.Label2.caption);

 setlength(cdata,(windowlength div 2));

 if (((xtime*rate)/1000)>(windowlength div 2)) and (((xtime*rate)/1000)<((slen3*rate/1000)-(windowlength div 2)))  then
 begin
  bin2freq:=rate/windowlength;
  sample:=round(xtime*rate/1000);
  oldmaxy:=rfjchart5.trace[1].ygmax;

  rfjchart5.traces:=1;
  rfjchart5.start:=0;
  rfjchart5.eind:=trunc(rxspinedit21.value);
  rfjchart5.backcolor:=clwhite;
  rfjchart5.trace[1].xaxispen.color:=clblack;
  rfjchart5.trace[1].yaxispen.color:=clblack;
  rfjchart5.trace[1].pen.color:=clblack;
  rfjchart5.trace[1].graphtitle:=currentfile+' at T= '+floattostrf(xtime,ffgeneral,6,2)+' msec';
  rfjchart5.trace[1].showtitle:=true;
  rfjchart5.trace[1].ygmin:=0;
  if checkbox18.Checked then rfjchart5.trace[1].ygmax:=maxy else rfjchart5.trace[1].ygmax:=2500;
  rfjchart5.trace[1].yaxislegend:='';
  rfjchart5.trace[1].clipy:=true;
  rfjchart5.drawmode:=dmbar;
  //rfjchart5.setmemsize(1,windowlength);
  rfjchart5.buffered:=false;
  rfjchart5.setuptraces;
  rfjchart5.drawaxes;


  for k:=0 to 4096 do slice[k]:=0;
  if (nofsamples>0) then
  begin
    maxpower:=21-scrollbar6.position;//trunc(rxspinedit1.value);;
    i:=-1;
    for k:=round(sample-(windowlength div 2)) to round(sample+(windowlength div 2)) do
    begin
     if (k<nofsamples) and (k>0) then
     begin
        inc(i);
        slice[i]:=wavdata[k];
     end;
    end;
   end;


   for i:=0 to 4096 do power[i]:=0;
   if checkbox47.Checked then
     AhoSpectrum(combobox6.ItemIndex,Windowlength,Power)
   else
     Getspectrum(combobox3.ItemIndex,Windowlength,Power);


  {
   for i:=0 to 4096 do ceps[i]:=0;
   for i:=0 to 4096 do
        if power[i]>0 then slice[i]:=ln(power[i]);

   //first we need a high-pass filter of the signal
   //to get rid of garbage in the low end of the cepstrum
    //cepstrum test
   if checkbox47.Checked then
     AhoSpectrum(combobox6.ItemIndex,Windowlength div 2,ceps)
   else
     Getspectrum(combobox3.ItemIndex,Windowlength div 2,ceps);

   form27.Show;
   with form27 do
   begin
     rfjchart1.buffered:=true;
     rfjchart1.traces:=1;
     rfjchart1.start:=0;
     rfjchart1.eind:=windowlength div 4;
     rfjchart1.trace[1].ygmin:=0;
     rfjchart1.trace[1].ygmax:=5;
     rfjchart1.setuptraces;
     rfjchart1.drawaxes;
     rfjchart1.addstart(1,1,10*(ceps[1]-1));
     for i:=1 to (windowlength div 4) do
     begin
        rfjchart1.addpoint(1,i,10*(ceps[i]-1));
     end;
     rfjchart1.update;
   end;
   }

   timeoffset:=0;
   if advspreadgrid1.Cells[4,currentrow]<>'' then
   begin
        T:=DateTimeToTimeStamp(strtofloat(advspreadgrid1.Cells[4,currentrow]));
        timeoffset:=T.Time;
        Timeoffset:=round(strtofloat(advspreadgrid1.Cells[6,currentrow]));  //rjrjrj
   end;
   if checkbox53.Checked then timeoffset:=0;

   if checkbox36.Checked then
   begin
    for i:=0 to advstringgrid1.rowcount-1 do
    begin
     if (advstringgrid1.cells[0,i]<>'') and (advstringgrid1.cells[1,i]<>'') then
     begin

      tbef:=strtofloat(advstringgrid1.cells[0,i]);
      tref:=xtime+timeoffset;
      taft:=strtofloat(advstringgrid1.cells[1,i]);
      //form21.AdvSpreadGrid1.Cells[3,form21.advspreadgrid1.rowcount-1]:=floattostr(tbef);
      //form21.AdvSpreadGrid1.Cells[4,form21.advspreadgrid1.rowcount-1]:=floattostr(tref);
      //form21.AdvSpreadGrid1.Cells[5,form21.advspreadgrid1.rowcount-1]:=floattostr(taft);

      if (strtofloat(advstringgrid1.cells[0,i])<=(xtime+timeoffset)) and (strtofloat(advstringgrid1.cells[1,i])>=(xtime+timeoffset)) then
      begin
       windowlength:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);

       env_start:=strtofloat(advstringgrid1.cells[0,i]);
       env_start_sample:=round((env_start-Timeoffset)*rate/1000);
       env_eind:=strtofloat(advstringgrid1.cells[1,i]);
       env_eind_sample:=round((env_eind-Timeoffset)*rate/1000);
       env_size:=env_eind_sample-env_start_sample;

       fft1_samples:=env_size div 2;
       fft1_start:=env_start_sample;
       fft1_eind:=env_start_sample+fft1_samples;
       fft1_blocks:=(fft1_eind-fft1_start) div windowlength;
       if fft1_blocks=0 then fft1_blocks:=1;

       fft2_samples:=env_size div 2;
       fft2_start:=env_eind_sample-fft2_samples;
       fft2_eind:=env_eind_sample;
       fft2_blocks:=(fft2_eind-fft2_start) div windowlength;
       if fft2_blocks=0 then fft2_blocks:=1;
       fft2_start:=fft2_eind-(fft2_blocks*windowlength);

       fft3_samples:=env_size div 2;
       fft3_mid:=env_start_sample+(env_size div 2);
       fft3_start:=fft3_mid-(fft3_samples div 2);
       fft3_eind:=fft3_start+fft3_samples;
       fft3_blocks:=(fft3_eind-fft3_start) div windowlength;
       if fft3_blocks=0 then fft3_blocks:=1;
       fft3_start:=fft3_mid -(fft3_blocks*windowlength div 2);
       fft3_eind:=fft3_mid +(fft3_blocks*windowlength div 2);

       fft4_samples:=env_size div 4;
       fft4_mid:=env_start_sample+(env_size div 2);
       fft4_start:=fft4_mid-(fft4_samples div 2);
       fft4_eind:=fft4_start+fft4_samples;
       {
       fft4_blocks:=(fft4_eind-fft4_start) div windowlength;
       if fft4_blocks=0 then fft4_blocks:=1;
       fft4_start:=fft4_mid -(fft4_blocks*windowlength div 2);
       fft4_eind:=fft4_mid +(fft4_blocks*windowlength div 2);
       }
       env_samples:=round((env_eind-env_start)*rate/1000);
       env_blocks:=env_samples div windowlength;
       if env_blocks=0 then env_blocks:=1;
       xoffset:=(env_samples-(env_blocks*windowlength)) div 2;
       //rfjchart5.setmemsize(1,windowlength);  //rfj 2006 15-12
       label82.caption:=inttostr(windowlength);
       bin2freq:=rate/windowlength;
       size:=(windowlength div 2)-2;
       realsize:=round(size*(2*trunc(rxspinedit21.value)/rate));
       zeromemory(@env_power,4096*sizeof(double));


       //use the 'modified normal' settings found below
       resolution:=trunc(rxspinedit4.value);
       blocks:=trunc((env_size-windowlength)/resolution);

       if blocks=0 then blocks:=1;
       if blocks<0 then blocks:=1;


       //TEST ZEROCROSSINGS & PEAK IN TIME DOMAIN
{
       //time domain zero crossings as estimate of fundamental frequency;
       //plot the current bit of wave to a graph
       //not needed in the final version?
       Tempchart.Show;
       Tempchart.rfjChart1.clear;
       Tempchart.rfjchart1.buffered:=true;
       Tempchart.rfjChart1.traces:=2;
       Application.ProcessMessages;
       Tempchart.rfjChart1.traces:=1;
       tempchart.rfjChart1.trace[1].memsize:= env_eind_sample-env_start_sample+1;
       Tempchart.rfjChart1.setuptraces;
       Tempchart.rfjChart1.drawaxes;
}
       //PEAK IN TIME DOMAIN
       maxpospeak:=0;
       maxpospeakat:=0;
       maxnegpeak:=0;
       maxpospeakat:=0;
       For k:=env_start_sample to env_eind_sample do
       begin
          wp:=wavdata[k];
          //Tempchart.rfjChart1.addpoint(1,k-env_start_sample,wp);
          if ((wp>0) and(wp>maxpospeak)) then
          begin
             maxpospeak:=wp;
             maxpospeakat:=k-env_start_sample;
          end;
          if ((wp<0) and (wp<maxnegpeak)) then
          begin
             maxnegpeak:=wp;
             maxnegpeakat:=k-env_start_sample;
          end;
       end;
      Tempchart.rfjChart1.autoscale(1);
      //END PEAK IN TIME DOMAIN

      //Filter for Zerocrossing
       SetLength(syl_wavdata,High(wavdata));
       LPfilterSyllable(env_start_sample,env_eind_sample);

       {
       //Optional plotting, only for debugging
       k:=env_start_sample;
       wp:=syl_wavdata[k-env_start_sample];
       Tempchart.rfjChart1.addstart(1,k-env_start_sample,wp);
       For k:=env_start_sample to env_eind_sample do
       begin
          wp:=syl_wavdata[k-env_start_sample];
          Tempchart.rfjChart1.addpoint(1,k-env_start_sample,wp);
       end;
       }

       zerocrossings:=0;
       lookforbelowzero:=False;
       lookforabovezero:=False;
       wp:=syl_wavdata[0];

       if wp>=0 then //waitforsamplebelowzero;
       begin
             lookforbelowzero:=true;
             lookforabovezero:=false;
       end;

       if wp<0 then //waitforsampleabovezero;
       begin
             lookforbelowzero:=false;
             lookforabovezero:=true;
       end;

       For k:=env_start_sample to env_eind_sample do
       begin
          wp:=syl_wavdata[k-env_start_sample];
          if (wp>0) and  lookforabovezero then
          begin
               inc(zerocrossings);
               //Tempchart.rfjChart1.setxmark(1,k-env_start_sample);
               lookforbelowzero:=true;
               lookforabovezero:=false;
          end;
          if (wp<0) and lookforbelowzero then
          begin
               inc(zerocrossings);
               //Tempchart.rfjChart1.setxmark(1,k-env_start_sample);
               lookforbelowzero:=false;
               lookforabovezero:=true;
          end;
       end;
       avgzerodistance:=(env_eind_sample-env_start_sample)/zerocrossings;
       avgzerodistance_time:=2*(avgzerodistance/rate);
       avgzerodistance_freq:=1/avgzerodistance_time;
       //tempchart.caption:=floattoStr(avgzerodistance_freq);

       //Tempchart.rfjChart1.autoscale(1);
       //p1:=Trunc(Tempchart.rfjChart1.trace[1].ygmin);
       //p2:=p1+1000;
       //Tempchart.rfjChart1.setxmark(1,maxpospeakat,p1,p2);
       //tempchart.caption:=inttostr(maxpeakat);
       //tempchart.rfjChart1.update;
       //tempchart.rfjChart1.bmp.SetSize(0,0);
       //Tempchart.rfjChart1.clear;
       //Application.ProcessMessages;
       //Sleep(2000);

       //END TEST ZEROCROSSINGS


       env_pointer:=env_start_sample;
       if (blocks>0) then setlength(cdata,blocks);
       for w:=1 to blocks do
       begin
         //fill the array SLICE with data from the WAV file
         env_pointer:=trunc(env_start_sample+((w-1)*resolution));
         zeromemory(@slice,4096*sizeof(double));
         j:=0;
         for k:=1 to windowlength do
         begin
           if (env_pointer<nofsamples) and (env_pointer>0) then
           begin
              tempvar:=wavdata[env_pointer];
              slice[j]:=tempvar;
              inc(env_pointer);
              inc(j);
           end;
         end;

         // do the FFT
         //AhoSpectrum(combobox6.ItemIndex,windowength,power);
         //Getspectrum(combobox3.ItemIndex,Windowlength,Power);

         //for i:=0 to 4096 do power[i]:=0;
         if checkbox47.Checked then
           AhoSpectrum(combobox6.ItemIndex,Windowlength,Power)
         else
           Getspectrum(combobox3.ItemIndex,Windowlength,Power);

         //
         //temp: compare real Wiener to BMP derived Wiener
         // bitmap clip32 bevat de data;
         sumspec:=0;
         for k:=0 to clip32.Height-1 do
               sumspec:=sumspec+(255-redcomponent(clip32.pixels[w-1,k]));
         amean2:=sumspec/clip32.Height;

         lnsumspec:=0;
         for k:=0 to clip32.Height-1 do
           if power[k]>0 then
              lnsumspec:=lnsumspec+ln(255-redcomponent(clip32.PixelS[w-1,k]));

         gmean2:=Exp(lnsumspec/clip32.Height);

         wiener2:=0;
         if amean2<>0 then wiener2:=ln(gmean2/amean2);
         //end temp: compare real Wiener to BMP derived Wiener


         //Do the calculations
         //mean, geometric mean, mode, wiener entropy, pitch
         //

         sumspec:=0;
         for k:=0 to size-1 do sumspec:=sumspec+power[k];
         amean:=sumspec/size;

         lnsumspec:=0;
         for k:=0 to size-1 do
           if power[k]>0 then
              lnsumspec:=lnsumspec+ln(power[k]);

         gmean:=exp(lnsumspec/size);

         wiener:=0;
         if amean<>0 then wiener:=ln(gmean/amean);

         pmax:=0;
         mode:=-1;
         for k:=0 to size-1 do
         begin
           if power[k]>pmax then
           begin
             pmax:=power[k];
             mode:=k;
           end;
         end;

         {
         //phis test
         pbinsize:=1;
         for k:=1 to 1000 do phis[k]:=0;
         for k:=0 to size-1 do
         begin
             ptemp:=1000*(power[k]/pmax);
             pbin:=1+trunc(ptemp/pbinsize);
             phis[pbin]:=phis[pbin]+1;
         end;
         }


         //firstpeak test
         firstpeakfound:=false;
         firstpeak:=0;
         Firstpeaklevel:=0.2;
         belowlevel:=true;
         for k:=0 to Windowlength div 2 do
         begin
           if belowlevel and (not firstpeakfound) and (power[k]>0.2*pmax) then
           begin
              belowlevel:=false;
           end;
           if (not belowlevel) and  (not firstpeakfound) and (power[k]<0.2*pmax) then
           begin
              firstpeakfound:=true;
              firstpeak:=k;
              belowlevel:=true;
           end;
         end;


         sumwfreq:=0;
         wfreq:=0;
         for k:=0 to size-1 do sumwfreq:=sumwfreq+(k*power[k]);
         if sumspec<> 0 then wfreq:=sumwfreq/sumspec;

         //dimvector(mdata,4096);
         for k:=0 to Windowlength div 2 do  mdata1[k]:=power[k];
         QsortD(mdata1,mdata2,Windowlength div 2);
         Ubound:=Windowlength div 2;
         Lbound:=0;
         N := Ubound - Lbound + 1;
         N2 := N div 2 + Lbound - 1;
         if Odd(N) then
           Medianp := mdata2[N2 + 1]
         else
           Medianp := 0.5 * (mdata2[N2] + mdata2[N2 + 1]);


         cdata[w-1].meanfreq:=wfreq;
         cdata[w-1].modefreq:=mode;
         cdata[w-1].wiener:=wiener;
         cdata[w-1].amean:=amean;
         cdata[w-1].gmean:=gmean;
         cdata[w-1].median:=medianp;
         cdata[w-1].firstpeak:=firstpeak;

       end;
       //

       //calculate mean/SD of these parameters over the syllable;
       if (blocks>0) then
       begin
        localsum:=0;
        dimvector(data,blocks);
        for w:=0 to blocks-1 do data[w]:=0;
        for w:=1 to blocks do
        begin
         data[w-1]:=cdata[w-1].meanfreq;
        end;
        syl_meanfreq:=average(data,0,blocks);
        syl_meanfreqsd:=sqrt(variance(data,0,blocks,syl_meanfreq));
        //
        for w:=0 to blocks-1 do data[w]:=0;
        for w:=1 to blocks do
        begin
          data[w-1]:=cdata[w-1].modefreq;
        end;
        syl_modefreq:=average(data,0,blocks);
        syl_modefreqsd:=sqrt(variance(data,0,blocks,syl_modefreq));
        //
        for w:=0 to blocks-1 do data[w]:=0;
        for w:=1 to blocks do
        begin
          data[w-1]:=-cdata[w-1].wiener;
        end;
        syl_wiener:=average(data,0,blocks);
        syl_wienersd:=sqrt(variance(data,0,blocks,syl_wiener));
        syl_duration:=(env_eind-env_start);

        for w:=1 to blocks do
        begin
          data[w-1]:=-cdata[w-1].median;
        end;
        syl_median:=average(data,0,blocks);
        syl_mediansd:=sqrt(variance(data,0,blocks,syl_median));


        for w:=1 to blocks do
        begin
          data[w-1]:=cdata[w-1].firstpeak;
        end;
        syl_firstpeak:=average(data,0,blocks);
        syl_firstpeaksd:=sqrt(variance(data,0,blocks,syl_firstpeak));

        dimvector(data,0);
       end;
       //

       //modified normal: from middle symmetrical to both sides;
       if checkbox75.Checked then
       begin
        //env_pointer:=xoffset+trunc((env_start-Timeoffset)*rate/1000);
        env_pointer:=fft3_start;
        sheetsize:=realsize;
        for w:=1 to env_blocks do
        begin
         zeromemory(@slice,4096*sizeof(double));
         j:=0;
         for k:=1 to windowlength do
         begin
           if (env_pointer<nofsamples) and (env_pointer>0) then
           begin
              tempvar:=wavdata[env_pointer];
              slice[j]:=tempvar;
              inc(env_pointer);
              inc(j);
           end;
         end;
         zeromemory(@power,4096*sizeof(double));
         AhoSpectrum(combobox6.ItemIndex,windowlength,power);
         for k:=0 to realsize do env_power[k]:=env_power[k]+power[k];
        end;
        for k:=0 to realsize do env_power[k]:=env_power[k]/env_blocks;
       end;

       if checkbox76.Checked then
       begin
        //fft1 = first half of the syllable;
        env_pointer:=fft1_start;
        sheetsize:=realsize*2;
        for w:=1 to fft1_blocks do
        begin
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
              tempvar:=wavdata[env_pointer];
              slice[j]:=tempvar;
              inc(env_pointer);
              inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=0 to realsize do env_power[k]:=env_power[k]+power[k];
        end;
        for k:=0 to realsize do env_power[k]:=env_power[k]/env_blocks;

        //fft2 = second half of the syllable;
        env_pointer:=fft2_start;
        for w:=1 to fft2_blocks do
        begin
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
               tempvar:=wavdata[env_pointer];
               slice[j]:=tempvar;
               inc(env_pointer);
               inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=1 to realsize do env_power[k+realsize]:=env_power[k+realsize]+power[k];
        end;
        for k:=1 to realsize do env_power[k+realsize]:=env_power[k+realsize]/env_blocks;
       end;

       if checkbox77.Checked then
       begin
        //fft1 = first half of the syllable;
        env_pointer:=fft1_start;
        sheetsize:=realsize*3;
        for w:=1 to fft1_blocks do
        begin
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
              tempvar:=wavdata[env_pointer];
              slice[j]:=tempvar;
              inc(env_pointer);
              inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=0 to realsize do env_power[k]:=env_power[k]+power[k];
        end;
        for k:=0 to realsize do env_power[k]:=env_power[k]/env_blocks;

        //fft2 = second half of the syllable;
        env_pointer:=fft2_start;
        for w:=1 to fft2_blocks do
        begin
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
               tempvar:=wavdata[env_pointer];
               slice[j]:=tempvar;
               inc(env_pointer);
               inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=1 to realsize do env_power[k+realsize]:=env_power[k+realsize]+power[k];
        end;
        for k:=1 to realsize do env_power[k+realsize]:=env_power[k+realsize]/env_blocks;

        //fft3 = middle part of the syllable;
        env_pointer:=fft3_start;
        for w:=1 to fft3_blocks do
        begin
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
               tempvar:=wavdata[env_pointer];
               slice[j]:=tempvar;
               inc(env_pointer);
               inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=1 to realsize do env_power[k+realsize+realsize]:=env_power[k+realsize+realsize]+power[k];
        end;
        for k:=1 to realsize do env_power[k+realsize+realsize]:=env_power[k+realsize+realsize]/env_blocks;
       end;

       if checkbox80.Checked then
       begin
           //
           sheetsize:=realsize*4;
           env_pointer:=env_start_sample;
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
               tempvar:=wavdata[env_pointer];
               slice[j]:=tempvar;
               inc(env_pointer);
               inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=1 to realsize do env_power[k]:=env_power[k]+power[k];
           //
           env_pointer:=env_start_sample+((env_eind_sample-env_start_sample) div 2)-windowlength;
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
               tempvar:=wavdata[env_pointer];
               slice[j]:=tempvar;
               inc(env_pointer);
               inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=1 to realsize do env_power[k+realsize]:=env_power[k+realsize]+power[k];
           //
           env_pointer:=env_start_sample+((env_eind_sample-env_start_sample) div 2);
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
               tempvar:=wavdata[env_pointer];
               slice[j]:=tempvar;
               inc(env_pointer);
               inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=1 to realsize do env_power[k+realsize+realsize]:=env_power[k+realsize+realsize]+power[k];
           //
           env_pointer:=env_eind_sample-windowlength;
           zeromemory(@slice,4096*sizeof(double));
           j:=0;
           for k:=1 to windowlength do
           begin
             if (env_pointer<nofsamples) and (env_pointer>0) then
             begin
               tempvar:=wavdata[env_pointer];
               slice[j]:=tempvar;
               inc(env_pointer);
               inc(j);
             end;
           end;
           zeromemory(@power,4096*sizeof(double));
           AhoSpectrum(combobox6.ItemIndex,windowlength,power);
           for k:=1 to realsize do env_power[k+realsize+realsize+realsize]:=env_power[k+realsize+realsize+realsize]+power[k];

       end;

       allzero:=false;
       realsheetsize:=sheetsize+2;
       //form17.advspreadgrid1.Colcount:=realsheetsize+2;

       //if not allzero then
       begin
        if speccols=false then
        begin
              specdat[1].Data[1]:=realsheetsize+2;
              //specdat[1]:=realsheetsize+2;
              //blockwrite(spec,specdat[1],4,bwritten);
              speccols:=true;
        end;
        //form17.advspreadgrid1.Cells[0,form17.advspreadgrid1.rowcount-1]:=inttostr(round(env_start));
        specdat[1].Time:=env_start;
        specdatf[1].Time:=env_start;
        //blockwrite(spec,specdat[1],4,bwritten);

        specdat[1].Duration:=(env_eind-env_start);
        specdat[1].Filename:=currentfile;
        specdatf[1].Duration:=(env_eind-env_start);
        specdatf[1].Filename:=currentfile;
        //blockwrite(spec,specdat[1],4,bwritten);

        for k:=0 to realsheetsize-2 do
        begin
         power[k]:=env_power[k];
         specdat[1].Data[k+2]:=round(power[k]);
         //blockwrite(spec,specdat[1],4,bwritten);
        end;
        //specdat[1].Data[1]:=round(syl_duration);
        specdat[1].Data[2]:=round(syl_meanfreq);
        specdat[1].Data[3]:=round(syl_meanfreqSD);
        specdat[1].Data[4]:=round(syl_modefreq);
        specdat[1].Data[5]:=round(syl_modefreqSD);
        specdat[1].Data[6]:=round(100*syl_wiener);
        specdat[1].Data[7]:=round(100*syl_wienerSD);
        specdat[1].Data[8]:=round(100*syl_firstpeak);
        specdat[1].Data[9]:=round(100*syl_firstpeakSD);
        blockwrite(spec,specdat[1],1,bwritten);

        specdatf[1].Data[2]:=syl_meanfreq;
        specdatf[1].Data[3]:=syl_meanfreqSD;
        specdatf[1].Data[4]:=syl_modefreq;
        specdatf[1].Data[5]:=syl_modefreqSD;
        specdatf[1].Data[6]:=100*syl_wiener;
        specdatf[1].Data[7]:=100*syl_wienerSD;
        specdatf[1].Data[8]:=100*syl_firstpeak;
        specdatf[1].Data[9]:=100*syl_firstpeakSD;
        specdatf[1].Data[10]:=avgzerodistance_freq;
        specdatf[1].Data[11]:=maxpospeakat;
        specdatf[1].Data[12]:=maxnegpeakat;
        blockwrite(specf,specdatf[1],1,bwritten);

        //form17.advspreadgrid1.Cells[258,form17.advspreadgrid1.rowcount-1]:=currentfile;
        //form17.AdvSpreadGrid1.rowcount:=form17.AdvSpreadGrid1.rowcount+1;
        //form17.Show;
        inc(spec_written); label88.caption:=inttostr(spec_written);
        spectrumwritten:=true;


        //form21.advspreadgrid1.Cells[2,form21.advspreadgrid1.rowcount-1]:=inttostr(round(env_start));
        //form21.advspreadgrid1.Cells[3,form21.advspreadgrid1.rowcount-1]:=currentfile;
       end;

       //rfjchart2.setxmark(2,env_start+(1000*xoffset/rate)-timeoffset,0,trunc(rfjchart2.trace[2].ygmax));
       //rfjchart2.setxmark(2,(1000*env_pointer/rate),0,trunc(rfjchart2.trace[2].ygmax));
       //rfjchart2.update;
       //break;

      end;
     end;
    end;
   end;


   maxy:=0;
   pfreq:=trunc(rxspinedit53.value);

   //this draws the spectrum, only useful when visible.
   size:=(windowlength div 2)-2;
   for i:=1 to size do
   begin
             //testval:=trunc(maxpower*power[i]);
             testval:=round(power[i]);
             if (((i+1)*bin2freq)>pfreq) and (testval>maxy) then maxy:=trunc(testval);
             rfjchart5.addpoint(1,((i+1)*bin2freq),testval);
             spechisbin:=1+trunc(testval);
             med1[i]:=trunc(testval);
   end;

   rfjchart5.keepdata:=true;
   rfjchart5.trace[1].ygmin:=0;

   if (not checkbox22.Checked) and checkbox18.Checked then
           rfjchart5.trace[1].ygmax:=round(1.1*maxy) else rfjchart5.trace[1].ygmax:=2500;

   if checkbox22.Checked then rfjchart5.trace[1].ygmax:=oldmaxy;

   rfjchart5.setuptraces;
   rfjchart5.drawaxes;
   rfjchart5.drawbuffer;

   //find the peaks in the spectrun
   //size:=(windowlength div 2)-2;
   //Qsort(med1,med2,size);
   //medianspect:=med2[size div 2];

   //this part is an attempt to find the peaks in the spectrum
   //not really used anywhere

   pfreq:=trunc(rxspinedit53.value);

   //rfjchart5.setymark(1,pdrempel);
   //rfjchart5.setymark(1,pdrempel2);
   markcount:=0;
   firstpeak:=0;
   highpeak:=0;
   peakcounter:=0;
   size:=(windowlength div 2)-2;
   for i:=1 to size do
   begin
    if ((i-0.5)*bin2freq)>pfreq then
    begin
       //median
       medianrun:=trunc(rxspinedit56.value);
       zeromemory(@omgeving,51*sizeof(integer));
       zeromemory(@med2,windowlength*sizeof(integer));
       kp:=0;
       for k:=i-(medianrun div 2) to i+(medianrun div 2) do
       begin
         if (k>0) and (k<size) then
          begin
             testval:=trunc(maxpower*power[k]);
             omgeving[kp]:=trunc(testval);
             inc(kp);
          end;
       end;
       Qsort(omgeving,med2,medianrun);
       medianspect:=med2[medianrun div 2];
       if odd(medianrun) then  medianspect:=(med2[ceil(medianrun/2)]+med2[trunc(medianrun/2)]) div 2;
       pdrempel2:=round((rxspinedit55.value-1)*medianspect);
       pdrempel:=round(rxspinedit55.value*medianspect);


       //mean
       //meanrun:=trunc(rxspinedit56.value);
       //summeanspect:=0;
       //for k:=i-(meanrun div 2) to i+(meanrun div 2) do
       //begin
       //  if (k>0) and (k<size) then
       //  begin
       //      testval:=trunc(maxpower*power[k]);
       //      summeanspect:=summeanspect+testval;
       //   end;
       //end;
       //meanspect:=summeanspect/(meanrun+1);
       //pdrempel:=round(rxspinedit55.value*meanspect);
       //pdrempel2:=round(rxspinedit55.value*meanspect);

       //percentage of max.
       pdrempel:=trunc(rxspinedit52.value*rfjchart5.trace[1].ygmax);
       //pdrempel2:=trunc(rxspinedit54.value*rfjchart5.trace[1].ygmax);
       pdrempel2:=pdrempel-trunc(0.10*rfjchart5.trace[1].ygmax);
       if pdrempel2<0 then pdrempel:=0;

       pdrempel2:=pdrempel;

       rfjchart5.setymark(1,pdrempel);
       rfjchart5.setymark(1,pdrempel2);

       //rfjchart5.setymark(1,pdrempel,(i*bin2freq)-(0.5*bin2freq),(i*bin2freq)+(0.5*bin2freq));

       //testval:=trunc(maxpower*power[i-1]);
       testval:=power[i-1];
       if (testval<pdrempel) and under then    //stays under
       begin
        under:=true;
        tracking:=false;
       end;
       if (testval<pdrempel2) and (not under) then //level change over->under
       begin
           under:=true;
           tracking:=false;
           if (((peakat-0.5)*bin2freq)>pfreq) then
           begin
             rfjchart5.xmarktext:=floattostrf(((peakat-0.5)*bin2freq),ffgeneral,4,4);
             rfjchart5.setxmark(1,(peakat*bin2freq)-(0.5*bin2freq));
             inc(peakcounter);
             label80.Caption:=inttostr(peakcounter);
             peakdata[peakcounter]:=peakat*bin2freq;
             if firstpeak=0 then
             begin
                firstpeak:=(peakat*bin2freq)-(0.5*bin2freq);
                label78.Caption:=floattostrf(firstpeak,ffgeneral,4,4);
             end;
           end;
       end;
       if (testval>=pdrempel) and (not under) then  //stays over
       begin
         under:=false;
         tracking:=true;
       end;
       if (testval>=pdrempel) and under then //level change under->over
       begin
          under:=false;
          tracking:=true;
       end;
       if not tracking then peak:=0;
       if tracking and (testval>peak) and (((i-0.5)*bin2freq)>pfreq) then
       begin
         peak:=testval;
         peakat:=i;
         if peak>highpeak then
         begin
            highpeak:=peak;
            label79.Caption:=floattostrf(((i-0.5)*bin2freq),ffgeneral,4,4);
         end;
       end;
    end;
   end;
   //tot hier het vinden van de pieken

   rfjchart5.update;


   // autocorrelatie hier wellicht?

   //form27.show;
   //for j:=0 to 512 do acor[j]:=0;
   //for j:=1 to size-100 do
   //begin
   // for i:=0 to 99 do
   //  begin
   //      acor[i]:=acor[i]+power[j+i];
   //  end;
     {
     form27.rfjChart1.buffered:=true;
     form27.rfjChart1.traces:=1;
     form27.rfjChart1.setuptraces;
     form27.rfjChart1.addstart(1,0,acor[0]/100);
     for i:=0 to 99 do
     begin
       form27.rfjChart1.addpoint(1,i,acor[i]/100);
     end;
     form27.rfjchart1.autoscale(1);
     form27.Caption:=inttostr(j);
     form27.rfjChart1.update;
     application.ProcessMessages;
     }
   //end;
   {
   form27.rfjChart1.buffered:=true;
   form27.rfjChart1.traces:=1;
   form27.rfjChart1.setuptraces;

   form27.rfjChart1.addstart(1,0,acor[0]/100);
   for i:=0 to 99 do
     begin
       form27.rfjChart1.addpoint(1,i,acor[i]/100);
     end;
   form27.rfjchart1.autoscale(1);
   form27.rfjChart1.update;
   }
   {
   form27.rfjChart1.addstart(1,0,power[0]);
   for i:=0 to 512 do
     begin
       form27.rfjChart1.addpoint(1,i,power[i]);
     end;
   form27.rfjchart1.autoscale(1);
   form27.rfjChart1.update;
   }

   //einde autocorrelatie van het spectrum hier

   spechisbinsize:=rfjchart5.trace[1].ygmax/100;
   for i:=0 to (windowlength div 2)-2 do
   begin
              spechisbin:=1+trunc(maxpower*power[i]/spechisbinsize);
              if (spechisbin>=1) and (spechisbin<=100) then inc(spechis[spechisbin]);
   end;

   rfjchart11.traces:=1;
   rfjchart11.start:=0;
   rfjchart11.eind:=100*spechisbinsize;
   rfjchart11.trace[1].ygmin:=0;
   rfjchart11.trace[1].ygmax:=100; //nof bins in histogram
   rfjchart11.drawmode:=dmbar;
   rfjchart11.setuptraces;
   rfjchart11.drawaxes;
   //for i:=1 to 100 do rfjchart11.addpoint(1,(i*spechisbinsize)-(spechisbinsize/2),spechis[i]);
 end;
 setlength(cdata,0);

end;

procedure Tform1.CompareSpectra(x1,x2,y:integer;var R:double);
var p1,p2:array[0..4095] of double;
    windowlength:integer;
    sample:double;
    i,k:integer;
begin
{
  windowlength:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);
  sample:=round(rfjchart1.xpos2val(x1,y)*rate)/1000;
  if (nofsamples>0) then
  begin
   i:=-1;
   for k:=round(sample-(windowlength div 2)) to round(sample+(windowlength div 2)) do
   begin
     if (k<nofsamples) and (k>0) then
     begin
        inc(i);
        slice[i]:=wavdata[k];
     end;
   end;
  end;
  Getspectrum(combobox3.ItemIndex,Windowlength,Power);
  move(power[0],p1[0],(1+(windowlength div 2)-2)*sizeof(double));

  sample:=round(rfjchart1.xpos2val(x2,y)*rate)/1000;
  if (nofsamples>0) then
  begin
   i:=-1;
   for k:=round(sample-(windowlength div 2)) to round(sample+(windowlength div 2)) do
   begin
     if (k<nofsamples) and (k>0) then
     begin
        inc(i);
        slice[i]:=wavdata[k];
     end;
   end;
  end;
  Getspectrum(combobox3.ItemIndex,Windowlength,Power);
  move(power[0],p2[0],(1+(windowlength div 2)-2)*sizeof(double));

  nsp_corr(p1,p2,(1+(windowlength div 2)-2),R);
  //form6.rfjchart1.trace[1].graphtitle:=floattostr(R);
  //showcorrgraph((1+(windowlength div 2)-2),p1,p2);
}
end;

procedure Tform1.SpectrumCorrelationMap;
var p1,p2:array[0..4095] of double;
    windowlength:integer;
    sample,sample2:double;
    i,k:integer;
    t1,t2,T3,halftime:double;
    Step,Step2:integer;
    Steps:integer;
    overlap:integer;
    r:double;
    cmap:Tbitmap32;
    T: TAffineTransformation;
    SrcR,SrcB:integer;
    sb,tb:tbitmap32;
    bin2freq:double;
    lf,uf,th,thR:double;
    R_FACTOR:double;
begin
{
 //left half
 sb:=Tbitmap32.create;
 sb.Height:=rfjChart1.trace[2].background.height;
 sb.width:=rfjChart1.trace[2].background.width div 2;
 rfjChart1.trace[2].background.drawto(sb,
                                      rect(0,0,sb.Width,sb.height),
                                      rect(0,0,sb.Width,sb.height)
                                      );
 form7.Image322.Bitmap.assign(sb);

 //right half, rotated
 rfjChart1.trace[2].background.drawto(sb,
                                      rect(0,0,sb.Width,sb.height),
                                      rect(sb.Width,0,rfjChart1.trace[2].background.width-1,rfjChart1.trace[2].background.height-1)
                                      );

 tb:=Tbitmap32.create;
 tb.Width:=sb.Height;
 tb.Height:=sb.Width;
 tb.Clear(clblue32);

 T := TAffineTransformation.Create;
 T.Clear;
 T.Translate(-Sb.width , 0);
 T.SrcRect := FloatRect(0, 0, sb.Width, sb.Height);
 T.Rotate(0, 0, 90);
 Transform(tb, sb, T);
 //T.Translate(Sb.width / 2, Sb.height / 2);
 form7.Image323.Bitmap.Assign(tb);

 T.free;
 sb.Free;
 tb.Free;

 windowlength:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);
 bin2freq:=rate/windowlength;
 T1:=round(RXSPINEDIT12.VALUE*rate/1000)+(windowlength div 2);
 T3:=round(RXSPINEDIT13.VALUE*rate/1000)-(windowlength div 2);
 halftime:=(T3-T1)/2;
 T2:=T1+halftime;

 overlap:=trunc(rxspinedit4.value);
 Steps:=round((T2-T1)/overlap);

 cmap:=Tbitmap32.Create;
 cmap.setsize(steps,steps);

 For step:=1 to Steps do
 begin
   lf:=form7.rxspinedit2.Value;
   uf:=form7.rxspinedit3.Value;
   th:=form7.rxspinedit4.Value;
   thR:=form7.rxspinedit5.Value;

   sample:=T1+(Step*overlap);
   if (nofsamples>0) then
   begin
    i:=-1;
    for k:=round(sample-(windowlength div 2)) to round(sample+(windowlength div 2)) do
    begin
     if (k<nofsamples) and (k>0) then
     begin
        inc(i);
        slice[i]:=wavdata[k];
     end;
    end;
   end;
   Getspectrum(combobox3.ItemIndex,Windowlength,Power);
   for i:=1 to (windowlength div 2)-2 do
   begin
       if (((i*bin2freq)<lf) or ((i*bin2freq)>uf)) or (power[i]<th) then power[i]:=0;
   end;
   move(power[0],p1[0],(1+(windowlength div 2)-2)*sizeof(double));

   // compare to all the other possibble spectra............
   For step2:=1 to Steps do
   begin
     sample2:=T2+(Step2*overlap);
     if (nofsamples>0) then
     begin
      i:=-1;
      for k:=round(sample2-(windowlength div 2)) to round(sample2+(windowlength div 2)) do
      begin
       if (k<nofsamples) and (k>0) then
        begin
         inc(i);
         slice[i]:=wavdata[k];
        end;
      end;
    end;
    Getspectrum(combobox3.ItemIndex,Windowlength,Power);
    for i:=1 to (windowlength div 2)-2 do
    begin
        if (((i*bin2freq)<lf) or ((i*bin2freq)>uf)) or (power[i]<th) then power[i]:=0;
    end;
    move(power[0],p2[0],(1+(windowlength div 2)-2)*sizeof(double));
    nsp_corr(p1,p2,trunc((1+(windowlength div 2)-2)/2),R);

    if form7.CheckBox1.Checked then
    begin
      //form6.rfjchart1.trace[1].graphtitle:=floattostr(r);
      //showcorrgraph((1+(windowlength div 2)-2),p1,p2);
      form7.image321.Bitmap.Assign(cmap);
      form7.caption:=inttostr(step);
      form7.show;
      application.ProcessMessages;
      sleep(trunc(form7.rxspinedit1.value));
    end;

    //range for R is -1 to +1
    if r<0 then r:=0;
    r_factor:=1/(1-form7.rxspinedit5.value);
    if (abs(R)>0.97) or (abs(R)<thR)then
        cmap.pixels[step,cmap.Height-step2]:=color32(color_calibrate2.Val2Color(0))
    else
        cmap.pixels[step,cmap.Height-step2]:=color32(color_calibrate2.Val2Color(round((r-form7.rxspinedit5.value)*r_factor*1024)));
   end;
   if not form7.CheckBox1.Checked then
   begin
     form7.image321.Bitmap.Assign(cmap);
     form7.caption:=inttostr(step);
     form7.show;
   end;
   application.ProcessMessages;
 end;
 cmap.SaveToClipboard;
 cmap.free
}
end;

procedure Tform1.showcorrgraph(points:integer;var p1,p2:array of double);
var i:integer;
    maxx,maxy:double;
    minx,miny:double;
begin
{
    maxx:=0;
    maxy:=0;
    minx:=maxint;
    miny:=maxint;
    for i:=0 to points-1 do
    begin
        if p1[i]>maxx then maxx:=p1[i];
        if p1[i]<minx then minx:=p1[i];

        if p2[i]>maxy then maxy:=p2[i];
        if p2[i]<miny then miny:=p2[i];
    end;
    with form6 do
    begin
      rfjchart1.traces:=1;
      rfjchart1.start:=0;
      rfjchart1.eind:=round(maxx);
      rfjchart1.trace[1].ygmin:=miny;
      rfjchart1.trace[1].ygmax:=maxy;
      rfjchart1.drawmode:=dmpoint;
      rfjchart1.backcolor:=clwhite;
      rfjchart1.trace[1].pen.color:=clblack;
      rfjchart1.trace[1].xaxispen.color:=clblack;
      rfjchart1.trace[1].yaxispen.color:=clblack;
      rfjchart1.trace[1].showtitle:=true;
      rfjchart1.setuptraces;
      rfjchart1.drawaxes;
      for i:=0 to points-1 do
      begin
         if (p1[i]>(0.05*maxx)) and (p2[i]>(0.05*maxy)) then
             rfjchart1.addpoint(1,p1[i],trunc(p2[i]));
      end;
      rfjchart2.traces:=2;
      rfjchart2.start:=0;
      rfjchart2.eind:=points;
      rfjchart2.trace[2].ygmin:=miny;
      rfjchart2.trace[2].ygmax:=maxy;
      rfjchart2.trace[1].ygmin:=minx;
      rfjchart2.trace[1].ygmax:=maxx;
      rfjchart2.drawmode:=dmbar;
      rfjchart2.backcolor:=clwhite;
      rfjchart2.trace[1].pen.color:=clblack;
      rfjchart2.trace[1].xaxispen.color:=clblack;
      rfjchart2.trace[1].yaxispen.color:=clblack;
      rfjchart2.trace[2].pen.color:=clblack;
      rfjchart2.trace[2].xaxispen.color:=clblack;
      rfjchart2.trace[2].yaxispen.color:=clblack;
      rfjchart2.setuptraces;
      rfjchart2.drawaxes;
      rfjchart2.reset;
      for i:=0 to points-1 do
      begin
             rfjchart2.addpoint(1,i,trunc(p1[i]));
             rfjchart2.addpoint(2,i,trunc(p2[i]));
      end;
      rfjchart1.update;
      rfjchart2.update;
      show;
    end;
}
end;

procedure Tform1.nsp_corr(datax,datay:array of double;points:integer;var corr:double);
var xmean,ymean:double;
    xsumsq,ysumsq:double;
    sumprod:double;
    xdifmean,ydifmean,prod:array [1..10000] of double;
    i,j:integer;
    deler:double;
begin
    nspdbzero(@xdifmean,Points);
    nspdbzero(@ydifmean,Points);

    xmean:=nspdmean(@DataX,Points);
    nspdbcopy(@dataX,@xdifmean,points);
    nspdbsub1(xmean,@xdifmean,Points);

    ymean:=nspdmean(@DataY,Points);
    nspdbcopy(@dataY,@ydifmean,Points);
    nspdbsub1(ymean,@ydifmean,Points);
    nspdbmpy3(@xdifmean,@ydifmean,@prod,points);
    sumprod:=0;
    for i:=1 to Points do
    begin
       sumprod:=sumprod+prod[i];
    end;
    nspdbsqr1(@xdifmean,Points);
    xsumsq:=0;
    for i:=1 to Points do
    begin
       xsumsq:=xsumsq+xdifmean[i];
    end;
    nspdbsqr1(@ydifmean,points);
    ysumsq:=0;
    for i:=1 to Points do
    begin
       ysumsq:=ysumsq+ydifmean[i];
    end;
    deler:=xsumsq*ysumsq;
    corr:=0;
    if deler>0 then
    begin
        Corr:=sumprod/sqrt(deler);
    end;
end;

procedure Tform1.Getspectrum(Windowmode,Windowlength:integer;var Power:array of double);
var sample:double;
    maxpower,windowpower,k,i,maxfreq,maxrows,rows:integer;
    bin2freq:double;
    maxy,testval:smallint;
    oldmaxy:double;
    scale:integer;
begin
  scale:=0;
  case windowmode of
          0: nspdWinBlackmanStd(@slice,windowlength);
          1: nspdwinblackmanopt(@slice,windowlength);
          2: nspdwinhamming(@slice,windowlength);
          3: nspdwinhann(@slice,windowlength);
          4: nspdwinbartlett(@slice,windowlength);
          5: //dummy
  end;
  case windowlength of
        128:windowpower:=7;
        256:windowpower:=8;
        512:windowpower:=9;
        1024:windowpower:=10;
        2048:windowpower:=11;
        4096:windowpower:=12;
  end;
  nspdrealfftl(@slice,windowpower,(NSP_forw or NSP_InRCPack or NSP_outrcpack));
  //nspwrealfftl(@shortslice,windowpower,(NSP_forw or NSP_InRCPack or NSP_outrcperm),NSP_No_Scale,scale);

  for i:=0 to (windowlength div 2)-2 do
  begin
             power[i]:=(1+(2*sqrt((slice[2*i+1]*slice[2*i+1])+(slice[2*i+2]*slice[2*i+2]))/windowlength));
             //power[i]:=20*log10(1+(2*sqrt((slice[2*i+1]*slice[2*i+1])+(slice[2*i+2]*slice[2*i+2]))/windowlength));
  end;
end;

procedure Tform1.GetspectrumI(Windowmode,Windowlength:integer;var Power:array of double);
var sample:double;
    maxpower,windowpower,k,i,maxfreq,maxrows,rows:integer;
    bin2freq:double;
    maxy,testval:smallint;
    oldmaxy:double;
    scalemode,scalefactor:integer;
    p1,p2:double;
begin
  case windowmode of
          0: nspwWinBlackmanStd(@islice,windowlength);
          1: nspwwinblackmanopt(@islice,windowlength);
          2: nspwwinhamming(@islice,windowlength);
          3: nspwwinhann(@islice,windowlength);
          4: nspwwinbartlett(@islice,windowlength);
          //5: nspwWinBlackman(@islice,windowlength);
          //6: nspwWinKaiser(@islice,windowlength);
  end;
  case windowlength of
        128:windowpower:=7;
        256:windowpower:=8;
        512:windowpower:=9;
        1024:windowpower:=10;
        2048:windowpower:=11;
        4096:windowpower:=12;
  end;
  scalemode:=NSP_NO_SCALE;
  scalefactor:=NSP_SATURATE;
  nspwRealFftl(@islice,windowpower,(NSP_forw or NSP_InRCPack or NSP_outrcpack),scalemode,scalefactor);
  for i:=0 to (windowlength div 2)-2 do
  begin
             p1:=islice[2*i+1]*islice[2*i+1];
             p2:=islice[2*i+2]*islice[2*i+2];
             power[i]:=(1+(2*sqrt(p1+p2)/windowlength));
  end;
end;

procedure TForm1.RxSpinEdit13Change(Sender: TObject);
begin
   //if rxspinedit13.value<= rxspinedit12.value then rxspinedit13.value:=strtofloat(label16.caption);
   Undolevel:=0;
   Button70.caption:='Un-edit '+inttostr(Undolevel);
   env_calc:=false;
   recalcsonogram:=true;
end;

procedure Tform1.processfile;
var filesize:string;
    minsize,maxsize:integer;
    sr: TSearchRec;
    FileAttrs: Integer;
    arg1,arg2:string;
    filename:string;
    fileinfo:string;
    zipdir:string;
    l:integer;
    t1,t2,freq:int64;
    elapsed:integer;
    arow,acol:integer;
    T:TTimestamp;
begin
 if checkbox28.Checked then rxgifanimator4.Show;
 statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
 memo1.Lines.Add('processfile '+DateTimeToStr(Now));
 startsample:=round(rxspinedit12.value*rate/1000);
 eindsample:=round(rxspinedit13.value*rate/1000);
 arow:=currentrow;
 acol:=currentcol;
 queryperformancecounter(t1);
 if acol=0 then
 begin
  if not zip then
  begin
   opendialog1.FileName:=filepath+'\'+advspreadgrid1.Cells[acol,arow]+'.wav';
   statusbar1.Panels[5].Text:=opendialog1.FileName;
   currentfile:=opendialog1.FileName;
   if not fileread then showwave;
   if checkbox10.Checked then
   begin
     StartHPfilter;
     if not filefiltered then filter;
   end;
   recalcsonogram:=true;
   chart2;
   if (pagecontrol1.ActivePage=tabsheet2) and checkbox9.checked then count2;
   //application.ProcessMessages;
   //if checkbox7.Checked then if checkbox47.Checked then aho_sonogram2 else sonogram2;
   if checkbox1.Checked then Play;
  end;
  if zip then
  begin
     if not fileread then
     begin
        opendialog1.FileName:='c:\temp\wavcount.wav';
        path:=PathWithoutRightElement(form1.opendialog1.filename,'\');
        zipdir:=extractfilepath(form1.zipfilename);
        ZipMaster1.ZipFileName:=form1.zipfilename;
        ZipMaster1.FSpecArgs.Clear;

        if fromCSV then
        begin
          path:=PathWithoutRightElement(form1.opendialog2.filename,'\');
          l:=length(form1.opendialog2.filename)-3;
          Zipfilename:=copy(form1.opendialog2.filename,1,L)+'ZIP';
          zipdir:=extractfilepath(form1.zipfilename);
          ZipMaster1.ZipFileName:=form1.zipfilename;
          ZipMaster1.FSpecArgs.Clear;
        end;

        arg1:=advspreadgrid1.Cells[5, arow];
        arg2:=advspreadgrid1.Cells[0, arow];
        statusbar1.Panels[5].Text:=arg2;
        ZipMaster1.FSpecArgs.Add(arg1+arg2);
        //form1.caption:=arg1+arg2;
        ZipMaster1.ExtrBaseDir:='';
        setcurrentdir('');
        try
            ZipMaster1.Extract;
            if Fileexists(''+arg2) then
             begin
              deletefile('wavcount.wav');
              renamefile(''+arg2,'c:\temp\wavcount.wav');
              currentfile:=advspreadgrid1.Cells[0,arow];
             end
            else
             ShowMessage( 'Error in Extract; Fatal DLL Exception in mainunit' );
         except
            ShowMessage( 'Error in Extract; Fatal DLL Exception in mainunit' );
         end;
         showwave;
     end;
     ///
     ///
     if checkbox10.Checked then
     begin
       StartHPfilter;
       if not filefiltered then filter;
     end;
     if checkbox45.Checked and not filefiltered then filter2;
     recalcsonogram:=true;
     chart2;
     if (pagecontrol1.ActivePage=tabsheet2) and checkbox3.Checked then count2;
     if checkbox1.Checked then Play;
  end;
 end;
 advspreadgrid1.Align:=alclient;
 if checkbox29.Checked then
 begin
   queryperformancecounter(T2);
   queryperformancefrequency(freq);
   elapsed:=round(1000*(t2-T1)/freq);
   memo1.Lines.Add(inttostr(elapsed)+' processing '+DateTimeToStr(Now));
 end;
  xoffset:=0;
  if advspreadgrid1.Cells[4,arow]<>'' then
  begin
        T:=DateTimeToTimeStamp(strtofloat(advspreadgrid1.Cells[4,arow]));
        xoffset:=T.Time;
        xoffset:=round(strtofloat(advspreadgrid1.Cells[6,currentrow]));  //rjrjrj        
  end;
  if checkbox53.Checked then xoffset:=0;

 statusbar1.Panels[4].Text:='';statusbar1.Update;
 //schannel_rightscroll_change(Self);
 rxgifanimator4.hide;
end;

procedure TForm1.Button14Click(Sender: TObject);
var windowsize:double;
begin
  Undolevel:=0;
  Button70.caption:='Un-edit '+inttostr(Undolevel);
  startsample:=round(rxspinedit12.value*rate/1000);
  eindsample:=round(rxspinedit13.value*rate/1000);
  adjustTime:=false;
  recalcsonogram:=true;
  if checkbox46.Checked then env_calc:=false;
  startsample:=round(rxspinedit12.value*rate/1000);
  eindsample:=round(rxspinedit13.value*rate/1000);
  if fileread then processfile;
  adjustTime:=true;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  rxspinedit12.value:=0;
  rxspinedit13.value:=slen3;
  button14click(self);
end;

procedure TForm1.rfjChart2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
var trace:integer;
    bmpx,bmpy:integer;
    bmpxtime:double;
    bmpyval:double;
    src,dst:Trect;
    t:Ttimestamp;
    grey:integer;
    i,px,py:integer;
begin
 mx:=x;
 my:=y;
 if rfjchart2.doscroll then
 begin
   mx:=x+trunc(rfjchart2.chart.HScroll.position);
 end;
 //form1.Caption:=inttostr(mx);
 if checkbox71.Checked then
 begin
     if (mx>magrect) and (my>magrect) and ((mx-rfjchart2.chart.HScroll.position)<rfjchart2.chart.Width-(magrect+20)) and (my<rfjchart2.chart.height-(magrect+20)) then
     begin
      src:=rect(mx-magrect,my-magrect,mx+magrect+1,my+magrect);
      dst:=rect(0,0,form14.image321.bitmap.width,form14.image321.bitmap.height);
      rfjchart2.chart.Bitmap.DrawTo(form14.image321.bitmap,dst,src);
      form14.Image321.Bitmap.HorzLine(0,form14.image321.bitmap.height div 2,form14.image321.bitmap.width-1,clblue32);
      form14.Image321.Bitmap.VertLine(form14.image321.bitmap.width div 2,0,form14.image321.bitmap.height-1,clblue32);
      form14.image321.Update;
     end;
 end;
 trace:=0;
 trace:=rfjchart2.getchannel(x,y);
 if mouseisdown and (not rfjchart2.doscroll) then
  begin
     rfjchart2.update;
      if mx>mousedownx then
         rfjchart2.chart.Bitmap.FrameRects(mousedownx,1,mx,rfjchart2.bmp.Height-1,clred32);
      if mx<mousedownx then
         rfjchart2.chart.Bitmap.FrameRects(mx,1,mousedownx,rfjchart2.bmp.Height-1,clred32);
  end
 else
  begin
   if checkbox20.Checked then
   begin
    rfjchart2.update;
    //rfjchart2.bmp.drawto(rfjchart2.chart.Bitmap,
    //                     rect(mx-10,1,mx+10,rfjchart2.chart.height-1),
    //                     rect(mx-10,1,mx+10,rfjchart2.chart.height-1));
    rfjchart2.chart.Bitmap.lines(mx,1,mx,rfjchart2.chart.height-1,clred32);
   end;
   if fileread then
   begin
    trace:=rfjchart2.getchannel(x,y);
    points_at_trace:=trace;
    //
    xoffset:=0;
    if advspreadgrid1.Cells[4,currentrow]<>'' then
    begin
        if advspreadgrid1.Cells[6,currentrow]<>'' then
            xoffset:=strtoint(advspreadgrid1.Cells[6,currentrow])
        else
          begin
            T:=DateTimeToTimeStamp(strtofloat(advspreadgrid1.Cells[4,currentrow]));
            xoffset:=T.Time;
            xoffset:=round(strtofloat(advspreadgrid1.Cells[6,currentrow]));  //rjrjrj            
          end;
    end;
    if checkbox53.Checked then xoffset:=0;
    //
    if trace<>schannel then
    begin
     form3.Label2.caption:=floattostrf(xoffset+(rfjchart2.xpos2val(mx,y)-form3.xoffset[trace]),fffixed,12,2);
     form3.Label4.caption:=floattostr(rfjchart2.ypos2val(mx,y));
     //form3.caption:=inttostr(trace);
     //(floattostrf(xoffset+gatetime,fffixed,12,2))
    end;
    if trace=schannel then
    begin
     bmpxtime:=rfjchart2.xpos2val(mx,y);
     bmpx:=trunc(((bmpxtime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);
     bmpyval:=rfjchart2.ypos2val(mx,y);
     bmpy:=fbmp2.height-trunc(((bmpyval-rfjchart2.trace[schannel].ygmin)/(rfjchart2.trace[schannel].ygmax-rfjchart2.trace[schannel].ygmin))*fbmp2.height);
     form3.Label6.caption:=inttostr(redcomponent(fbmp2.PixelS[bmpx,bmpy]));
     form3.Label2.caption:=floattostrf(xoffset+(rfjchart2.xpos2val(mx,y)-form3.xoffset[trace]),fffixed,12,2);
     //form3.Label2.caption:=floattostrf(rfjchart2.xpos2val(mx,y)-form3.xoffset[trace],fffixed,6,2);
     form3.Label4.caption:=floattostr(rfjchart2.ypos2val(mx,y));
     //form3.caption:=inttostr(trace);
     if checkbox15.Checked then
      if toolwindow976.Visible then
        if (x>rfjchart2.trace[1].yleft) and (x<rfjchart2.trace[1].yright) then spectrum(mx,y);
    end;
     {
    rfjchart1.trace[1].Ftext[1].text:=label7.caption;
    rfjchart1.trace[1].Ftext[2].text:=label15.caption;
    rfjchart1.trace[1].Ftext[1].xpos:=0;
    rfjchart1.trace[1].Ftext[1].ypos:=-10;
    rfjchart1.trace[1].Ftext[2].xpos:=100;
    rfjchart1.trace[1].Ftext[2].ypos:=-10;
    rfjchart1.drawtext;
    }
  end;
 end;
 //
 if trace=schannel then
 begin
   if checkbox79.Checked then form20.show;
   form20.rfjchart1.traces:=1;
   form20.rfjchart1.start:=0;
   form20.rfjchart1.eind:=fbmp2.height;
   form20.rfjchart1.trace[1].ygmin:=0;
   form20.rfjchart1.trace[1].ygmax:=256;
   form20.rfjchart1.drawmode:=dmskyline;
   form20.rfjchart1.setuptraces;
   form20.rfjchart1.drawaxes;
   for i:=0 to fbmp2.height do
   begin
       bmpxtime:=rfjchart2.xpos2val(mx,y);
       bmpx:=trunc(((bmpxtime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);
       //bmpyval:=rfjchart2.ypos2val(mx,y);
       //bmpy:=fbmp2.height-trunc(((bmpyval-rfjchart2.trace[schannel].ygmin)/(rfjchart2.trace[schannel].ygmax-rfjchart2.trace[schannel].ygmin))*fbmp2.height);
       grey:=0;if (py>0)and (px>0) then grey:=redcomponent(fbmp2.PixelS[bmpx,i]);
       form20.rfjchart1.addpoint(1,fbmp2.height-i,255-grey);
   end;
   form20.rfjchart1.update;
   //form20.caption:=inttostr(y);
 end;
 //

end;

procedure TForm1.Button16Click(Sender: TObject);
begin
    if printersetupdialog1.Execute then
    begin
     printer.orientation:=polandscape;
     printer.begindoc;
      rfjchart5.drawmode:=dmbar;
      rfjchart5.printmag:=0.71;
      rfjchart5.printeryoffset:=0;
      rfjchart5.printerxoffset:=0;
      rfjchart5.getprinterpar;
      rfjchart5.printerdrawaxes;
      rfjchart5.printer_trace[1].clipy:=true;
      rfjchart5.printerdrawbuffer;
     printer.enddoc;
    end;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin

   //if pagecontrol1.ActivePage=Tabsheet1 then rfjchart1.copytoclipboard;
   if pagecontrol1.ActivePage=Tabsheet2 then rfjchart2.copytoclipboard;
   //if pagecontrol1.ActivePage=Tabsheet10 then rfjchart3.trace[1].background.SaveToClipboard;
   if pagecontrol1.ActivePage=Tabsheet3 then imgview321.bitmap.SaveToClipboard;
   //if pagecontrol1.ActivePage=Tabsheet11 then rfjchart4.copytoclipboard;
   //
   if checkbox17.Checked then
    if printersetupdialog1.Execute then
    begin
     //if pagecontrol1.ActivePage=Tabsheet1 then begin rfjchart1.printmag:=rxspinedit15.Value/100;rfjchart1.print_as_bitmap;end;
     if pagecontrol1.ActivePage=Tabsheet2 then begin rfjchart2.printmag:=rxspinedit15.Value/100;rfjchart2.print_as_bitmap;end;
     //if pagecontrol1.ActivePage=Tabsheet10 then begin rfjchart3.printmag:=rxspinedit15.Value/100;rfjchart3.print_as_bitmap;end;
     //if pagecontrol1.ActivePage=Tabsheet3 then begin imgview321.rfjchart3.printmag:=rxspinedit15.Value/100;rfjchart3.print_as_bitmap;end;
     //if pagecontrol1.ActivePage=Tabsheet11 then begin rfjchart4.printmag:=rxspinedit15.Value/100;rfjchart4.print_as_bitmap;end;
    end
   else
    //if not printersetupdialog1.Execute then
    begin
     //if pagecontrol1.ActivePage=Tabsheet1 then rfjchart1.print_as_bitmap;
     rfjchart2.printmag:=rxspinedit15.Value/100;
     if pagecontrol1.ActivePage=Tabsheet2 then rfjchart2.print_as_bitmap;
     //if pagecontrol1.ActivePage=Tabsheet10 then rfjchart3.print_as_bitmap;
     //if pagecontrol1.ActivePage=Tabsheet3 then rfjchart3.print_as_bitmap;
     //if pagecontrol1.ActivePage=Tabsheet11 then rfjchart4.print_as_bitmap;
    end;
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  rfjchart5.copytoclipboard;
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
   savedialog1.filter:='Bitmap files (*.bmp)|*.BMP';
   //if pagecontrol1.ActivePage=Tabsheet1 then
   //    if savedialog1.Execute then rfjchart1.bmp.SaveToFile(savedialog1.filename);

   if pagecontrol1.ActivePage=Tabsheet2 then
       if savedialog1.Execute then rfjchart2.bmp.SaveToFile(savedialog1.filename);

   //if pagecontrol1.ActivePage=Tabsheet3 then
   //    if savedialog1.Execute then rfjchart3.bmp.SaveToFile(savedialog1.filename);

   //if pagecontrol1.ActivePage=Tabsheet10 then
   //    if savedialog1.Execute then rfjchart3.trace[1].background.SaveToFile(savedialog1.filename);

   //if pagecontrol1.ActivePage=Tabsheet11 then
   //    if savedialog1.Execute then rfjchart4.bmp.SaveToFile(savedialog1.filename);
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
   savedialog1.filter:='Bitmap files (*.bmp)|*.BMP';
   if savedialog1.Execute then rfjchart5.bmp.SaveToFile(savedialog1.filename);
end;

procedure TForm1.Button21Click(Sender: TObject);
var windowsize:double;
    shiftsize:double;
begin
   windowsize:=(rxspinedit13.value-rxspinedit12.value);
   shiftsize:=(rxspinedit10.value/100)*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit12.value:=rxspinedit12.value-shiftsize;
   rxspinedit13.value:=rxspinedit12.value+windowsize;
   button14click(self);
   //recalcsonogram:=true;
   //if fileread then processfile;
end;

procedure TForm1.Button9Click(Sender: TObject);
var windowsize:double;
    shiftsize:double;
begin
   windowsize:=(rxspinedit13.value-rxspinedit12.value);
   shiftsize:=(rxspinedit10.value/100)*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit13.value:=rxspinedit13.value+shiftsize;
   rxspinedit12.value:=rxspinedit13.value-windowsize;
   if rxspinedit13.value> slen3 then
   begin
      rxspinedit13.value:=slen3;
      rxspinedit12.value:=rxspinedit13.value-windowsize;
      showmessage('End of File reached');
   end;
   if rxspinedit12.value<0 then
   begin
      rxspinedit12.value:=0;
      rxspinedit13.value:=rxspinedit12.value+windowsize;
      showmessage('Start of File reached');
   end;
   button14click(self);
   //recalcsonogram:=true;
   //if fileread then processfile;
end;

procedure TForm1.rfjChart2click(Sender: TObject);
var button:Tmousebutton;
    m:Tmouse;
    gatelistpointer,i:integer;
    gatelist:array of double;
    mxtime:double;
    leftgate,rightgate:double;
    var memsize:integer;
    testhi,testlo:extended;
    gridrow:integer;
    prevgatelevel,gatelevel:integer;
    prevgateswitch,gateswitch:integer;
    gateinterval,gatetime:double;
    gdata:array of smallint;
    testgate:integer;
    testgatelevel:integer;
    fastnoise:boolean;
    j:integer;
    t1,t2,freq:int64;
    elapsed:integer;
    sono2time:double;
    testlevel:integer;
    darkcount,testcountlevel:integer;
    gatecol:integer;
    clip32:Tbitmap32;
    clip:Tbitmap;
    wenthigh:integer;
    hasbeenhigh:boolean;
    lotime,hitime:integer;
    realstart:integer;
    currenttime:double;
    realgatelevel:integer;
    leftsample,rightsample:integer;
begin
    //rfjchart2.showform;
    if checkbox20.Checked then
    begin
      rfjchart2.bmp.lines(mousedownx,1,mousedownx,rfjchart2.bmp.height-1,clred32);
      rfjchart2.update;
    end;
    if checkbox37.Checked then form3.show;
    if points_at_trace=1 then
     if form3.CheckBox2.checked then
     begin
       rfjchart2.marksize:=trunc(rxspinedit14.value);
       rfjchart2.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart2.update;
    end;
    if points_at_trace=2 then
     if form3.CheckBox2.checked then
     begin
       rfjchart2.marksize:=trunc(rxspinedit14.value);
       rfjchart2.setmark(2,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart2.update;
    end;
    if form3.CheckBox1.Checked then
    begin
      case points_at_trace of
        1:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Wave';
        2:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Sonogram';
        3:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Envelope';
        4:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Gate';
      end;
      //
      advstringgrid2.Cells[form3.currentcol,form3.currentrow]:=currentfile;
      advstringgrid2.ColWidths[form3.currentcol]:=abs(length(currentfile)*(advstringgrid2.Font.Size+1));
      //if advstringgrid2.ColWidths[form3.currentcol]>300 then advstringgrid2.ColWidths[form3.currentcol]:=300;
      //
      advstringgrid2.Cells[form3.currentcol+2,form3.currentrow]:=form3.Label2.caption;
      advstringgrid2.Cells[form3.currentcol+3,form3.currentrow]:=form3.Label4.caption;
      if form3.CheckBox1.Checked then inc(form3.currentrow);
      if form3.currentrow>advstringgrid2.rowcount then advstringgrid2.rowcount:=advstringgrid2.rowcount+1;
      advstringgrid2.row:=advstringgrid2.rowcount-1;
      advstringgrid2.Col:=4;
    end;
    if (points_at_trace=4) and checkbox72.checked then
    begin
      if checkbox36.Checked then
      begin
        inc(UndoLevel);
        Button70.caption:='Un-edit '+inttostr(Undolevel);
        WriteEbuffer(UndoLevel,Nofsamples);
      end;
      gatelistpointer:=-1;
      setlength(gatelist,(advstringgrid1.rowcount*2));
      for i:=0 to advstringgrid1.rowcount do
      begin
         inc(gatelistpointer);
         if advstringgrid1.Cells[0,i]<>'' then gatelist[gatelistpointer]:=strtofloat(advstringgrid1.Cells[0,i]);
         inc(gatelistpointer);
         if advstringgrid1.Cells[1,i]<>'' then gatelist[gatelistpointer]:=strtofloat(advstringgrid1.Cells[1,i]);
      end;
      mxtime:=strtofloat(form3.Label2.caption);
      testhi:=(slide[echannel].max-slide[echannel].Position);
      testlo:=(slide[echannel].max-slide[echannel].Position-rxspinedit22.value);
      for i:=0 to (advstringgrid1.rowcount*2)-1 do
      begin
         if (mxtime>gatelist[i]) and (mxtime<gatelist[i+1]) then
         begin
             leftgate:=gatelist[i];
             rightgate:=gatelist[i+1];
             leftsample:=trunc(rate*leftgate/1000);
             rightsample:=trunc(rate*rightgate/1000);
         end;
      end;
      if leftsample<10 then leftsample:=10;
      for i:=leftsample to rightsample do
      begin
        if ebuffer[leftsample-10]<testlo then ebuffer[i]:=0;
        if ebuffer[leftsample-10]>testhi then ebuffer[i]:=3*trunc(testhi);
      end;
     //////////////////////////////////////////////////////////////
     //GATE
     //advstringgrid1.beginupdate;
     for i:=0 to advstringgrid1.RowCount-1 do
     begin
       advstringgrid1.cells[0,i]:='';
       advstringgrid1.cells[1,i]:='';
       advstringgrid1.cells[2,i]:='';
     end;
     advstringgrid1.rowcount:=1;
     advstringgrid1.clear;
     gridrow:=-1;
     if checkbox52.checked then
     begin
       info2spreadsheet;
       gridrow:=0;
     end;
     clip32:=Tbitmap32.create;
     clip:=Tbitmap.Create;
     clip.pixelformat:=pf32bit;
     hasbeenhigh:=false;
     with rfjchart2 do
     begin
       erasetrace(gchannel);
       trace[gchannel].buffersize:=0;
       erasetrace(echannel);
       trace[echannel].buffersize:=0;
       drawallaxes;
       addarray(echannel,0,1000/rate,startsample,eindsample-1,ebuffer);
       setymark(echannel,(slide[echannel].max-slide[echannel].Position));
       setymark(echannel,(slide[echannel].max-slide[echannel].Position-trunc(rxspinedit22.value)));
       env_calc:=true;
       reset;
       rfjchart2.update;
       //application.processmessages;
     end;
     if checkbox16.Checked then
     begin
      slide[echannel].show;
      rfjchart2.drawmode:=dmline;
      rfjchart2.reset;
      testhi:=(slide[echannel].max-slide[echannel].Position);
      testlo:=(slide[echannel].max-slide[echannel].Position-rxspinedit22.value);
      advstringgrid1.Clear;
      gridrow:=-1;
      if checkbox52.checked then
      begin
       info2spreadsheet;
       gridrow:=0;
      end;
      if (ebuffer[startsample]>testhi) then prevgatelevel:=90 ;
      if (ebuffer[startsample]<testlo) then prevgatelevel:=0;
      hitime:=trunc(rate*rxspinedit24.value/1000);
      lotime:=trunc(rate*rxspinedit6.value/1000);
      //ravg-envelope en fir-envelope en sonogram envelope
      if checkbox11.Checked or checkbox13.Checked or checkbox46.Checked then
      begin
        i:=startsample;
        realstart:=startsample;
        fastnoise:=false;
        while i<eindsample-1 do
        begin
          if realstart>i then
          begin
              i:=realstart;
             //prevgatelevel:=realgatelevel;
          end;
          if ((1000*i/rate)<(leftgate-1)) or ((1000*i/rate)>(rightgate+1)) then
          begin
            if (ebuffer[i]>testhi) then gatelevel:=90 ;
            if (ebuffer[i]<testlo) then gatelevel:=0;
          end;
          if prevgatelevel=gatelevel then rfjchart2.addpoint(gchannel,1000*i/rate,gatelevel);
          if prevgatelevel<>gatelevel then
          begin
             //transition?
             fastnoise:=false;
             if gatelevel=90 then testgate:=hitime;
             if gatelevel=0 then testgate:=lotime;
             for j:=i to (i+testgate) do
             begin
                  if (ebuffer[j]>testhi) then testgatelevel:=90 ;
                  if (ebuffer[j]<testlo) then testgatelevel:=0;
                  if testgatelevel<>gatelevel then
                  begin
                     fastnoise:=true;
                     realstart:=j;
                     //realgatelevel:=testgatelevel;
                     break;
                  end;
             end;
             if fastnoise then gatelevel:=prevgatelevel;
             if not fastnoise then
             begin
               prevgateswitch:=gateswitch;
               gateswitch:=i;
               //gateinterval:=1000*((gateswitch-prevgateswitch)/rate);
               gatetime:=1000*i/rate;
               if gatelevel=90 then
               begin
                   inc(gridrow);
                   if gridrow>(advstringgrid1.RowCount-1) then advstringgrid1.RowCount:=advstringgrid1.RowCount+1;
                   advstringgrid1.Cells[0,gridrow]:=(floattostrf(xoffset+gatetime,fffixed,12,2));
                   //advstringgrid1.update;
                   if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
                   //
                   gatecol:=ceil(((gatetime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);
                   hasbeenhigh:=true;
                   wenthigh:=gatecol;
                   //
               end;
               if gatelevel=0 then
               begin
                    gateinterval:=1000*((gateswitch-prevgateswitch)/rate);
                    if gridrow<0 then
                    begin
                      gridrow:=0;
                      gateinterval:=0;
                    end;
                    advstringgrid1.Cells[1,gridrow]:=(floattostrf(xoffset+gatetime,fffixed,12,2));
                    advstringgrid1.Cells[2,gridrow]:=(floattostrf(gateinterval,fffixed,6,2));
                    //advstringgrid1.update;
                    if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
                    //
                    gatecol:=trunc(((gatetime-rfjchart2.start)/(rfjchart2.eind-rfjchart2.start))*fbmp2.width);
                    if hasbeenhigh and save_db then
                    begin
                     FStream := TMemoryStream.Create;
                     clip32.Width:=gatecol-wenthigh;
                     clip32.height:=fbmp2.Height;
                     fbmp2.DrawTo(clip32,
                                 rect(0,0,clip32.width,clip32.Height),
                                 rect(wenthigh-2,0,gatecol+2,fbmp2.height));

                     //clip32.SaveToClipboard;
                     png.CompressionLevel:=9;
                     png.Filters:=[pfNone, pfSub, pfUp, pfAverage, pfPaeth];
                     clip32.AssignTo(clip);
                     PNG.assign(clip);
                     png.SaveToStream(FStream);
                     FStream.seek(0,0);
                     FHead.Magic := 1234567; //constant value
                     FHead.BitmapSize := FStream.size;
                     FHead.edit1string := currentfile;
                     FHead.edit2string := floattostr(gatetime);
                     FHead.edit3string := 'dummytext';
                     FFile.Write(FHead,SizeOf(TMyRecord));
                     FFile.CopyFrom(FStream,FStream.size );
                     fstream.free;
                    end;
                    //
               end;
               rfjchart2.addpoint(gchannel,1000*i/rate,gatelevel);
               prevgatelevel:=gatelevel;
             end;
          end;
          inc(i);
        end;
      end;
      //
      if pagecontrol2.ActivePage=pagecontrol2.Pages[0] then makegatehis;
      if pagecontrol2.ActivePage=pagecontrol2.Pages[1] then makedurationhis;
     end;
     gridrows:=gridrow;
     rfjchart2.update;
     //////////////////////////////////////////////////////////////
    end;
end;

procedure TForm1.rfjChart3click(Sender: TObject);
begin
{
    form3.show;
    if form3.CheckBox2.checked then
    begin
       rfjchart3.marksize:=trunc(rxspinedit14.value);
       rfjchart3.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart3.update;
    end;
    if form3.CheckBox1.Checked then
    begin
      advstringgrid2.Cells[form3.currentcol,form3.currentrow]:=currentfile;
      advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:=tabsheet3.Caption;
      advstringgrid2.Cells[form3.currentcol+2,form3.currentrow]:=form3.Label2.caption;
      advstringgrid2.Cells[form3.currentcol+3,form3.currentrow]:=form3.Label4.caption;
      if form3.CheckBox1.Checked then inc(form3.currentrow);
      if form3.currentrow>advstringgrid2.rowcount then advstringgrid2.rowcount:=advstringgrid2.rowcount+1;
      advstringgrid2.row:=advstringgrid2.rowcount-1;
      advstringgrid2.Col:=4;
    end;
}
end;

procedure TForm1.ImgView321Click(Sender: TObject);
begin
    if checkbox37.Checked then form3.show;
end;

procedure TForm1.rfjChart4click(Sender: TObject);
begin
    if checkbox37.Checked then form3.show;
end;

procedure TForm1.rfjChart5click(Sender: TObject);
begin
    if checkbox37.Checked then form3.show;
    if form3.CheckBox2.checked then
    begin
       rfjchart5.marksize:=trunc(rxspinedit14.value);
       rfjchart5.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart5.update;
    end;
    if form3.CheckBox1.Checked then
    begin
      advstringgrid2.Cells[form3.currentcol,form3.currentrow]:=currentfile;
      //advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:=tabsheet8.Caption;
      advstringgrid2.Cells[form3.currentcol+2,form3.currentrow]:=form3.Label2.caption;
      advstringgrid2.Cells[form3.currentcol+3,form3.currentrow]:=form3.Label4.caption;
      if form3.CheckBox1.Checked then inc(form3.currentrow);
      if form3.currentrow>advstringgrid2.rowcount then advstringgrid2.rowcount:=advstringgrid2.rowcount+1;
      advstringgrid2.row:=advstringgrid2.rowcount-1;
      advstringgrid2.Col:=4;
    end;
end;


procedure TForm1.rfjChart4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
    form3.Label2.caption:=floattostr(rfjchart4.xpos2val(x,y));
    form3.Label4.caption:=floattostr(rfjchart4.ypos2val(x,y));
end;

procedure TForm1.CheckBox19Click(Sender: TObject);
begin
 chart2;
end;

procedure TForm1.CheckBox20Click(Sender: TObject);
begin
   //if not checkbox20.Checked then sonogram;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
   case radiogroup2.ItemIndex of
   0: begin
       if savedialog3.Execute then advstringgrid2.SaveToXLS(savedialog3.FileName+'.XLS');
      end;
   1: begin
       if savedialog3.Execute then advstringgrid2.SaveToASCII(savedialog3.FileName+'.asc');
      end;
   2: begin
       if savedialog3.Execute then advstringgrid2.SaveToHTML(savedialog3.FileName+'.html');
      end;
   3: begin
       if savedialog3.Execute then advstringgrid2.SaveToDOC(savedialog3.FileName+'.doc');
      end;
   4: begin
       if savedialog3.Execute then advstringgrid2.SaveToCSV(savedialog3.FileName+'.csv');
      end;
   end;
end;

procedure TForm1.rfjChart4resize(Sender: TObject);
begin
  rfjchart4.resize;
end;

procedure TForm1.CheckBox24Click(Sender: TObject);
begin
StartHPfilter;
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
begin
   recalcsonogram:=true;
   StartHPfilter
end;

{
procedure TForm1.rfjChart1mousedown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if  toolwindow976.Visible then
 begin
    mousedownx:=x;
    mousedowny:=y;
    zoomymin:=round(rfjchart1.ypos2val(mouseupx,mouseupx));
     if rfjchart1.getchannel(x,y)=2 then
       if (x>rfjchart1.trace[1].yleft) and (x<rfjchart1.trace[1].yright) then spectrum(x,y);
  end;
end;
}

procedure TForm1.ComboBox5Click(Sender: TObject);
var width:extended;
begin
  width:=(rate div 2)/strtoint(combobox1.Items.strings[combobox1.ItemIndex]);
  //label24.caption:=floattostrf(width,fffixed,6,2);
end;

procedure TForm1.CheckBox25Click(Sender: TObject);
begin
   recalcsonogram:=true;
   if checkbox46.Checked then env_calc:=false;
   chart2;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   showfilterkar;
   Form8.LUTControl1Change(Self);
end;

procedure TForm1.RxSpinEdit13TopClick(Sender: TObject);
begin
 beep;
end;

procedure TForm1.RxSpinEdit16Change(Sender: TObject);
begin
  if (rxspinedit16.Value>0) and checkbox78.checked then
  begin
    showwave;
    button59click(self);
  end;
end;

procedure TForm1.left1Click(Sender: TObject);
begin
  S1:=mx;
end;

procedure TForm1.right1Click(Sender: TObject);
begin
  s2:=mx;
end;

procedure TForm1.zoom1Click(Sender: TObject);
var r:double;
begin
 // CompareSpectra(s1,s2,rfjchart1.trace[2].xtop+1,R);
end;

procedure TForm1.ScrollBar6Change(Sender: TObject);
var m:tmouse;
begin
    if checkbox12.checked and not (m.isdragging) then if checkbox47.Checked then aho_sonogram2 else sonogram2;
    form8.show;
end;

procedure TForm1.ScrollBar7Change(Sender: TObject);
begin
   rfjChart12click(Self);
end;

procedure TForm1.CheckBox23Click(Sender: TObject);
var i:integer;
begin
 rfjchart2.trace[schannel].background:=nil;
 if wchannel>0 then rfjchart2.savetrace(wchannel,wchannel_settings);
 if schannel>0 then rfjchart2.savetrace(schannel,schannel_settings);
 if echannel>0 then rfjchart2.savetrace(echannel,echannel_settings);
 if gchannel>0 then rfjchart2.savetrace(gchannel,gchannel_settings);
 wchannel:=0;
 schannel:=0;
 echannel:=0;
 gchannel:=0;
 for i:=rfjchart2.traces downto 1 do
 begin
    slidepanel[i].free;
    slidepanel[i]:=nil;
    slidepanel2[i].free;
    slidepanel2[i]:=nil;
 end;
 channelcount:=0;
 if checkbox23.Checked then
 begin
   inc(channelcount);
   wchannel:=channelcount;
 end;
 if checkbox5.Checked then
 begin
   inc(channelcount);
   schannel:=channelcount;
 end;
 if checkbox36.Checked then
 begin
   inc(channelcount);
   echannel:=channelcount;
 end;
 if checkbox16.Checked then
 begin
   inc(channelcount);
   gchannel:=channelcount;
 end;
 if pagecontrol1.ActivePage=tabsheet2 then chart2;
end;


procedure TForm1.mark1Click(Sender: TObject);
begin
  //rfjchart1.setxmark(1,strtofloat(form3.label2.caption));
end;

procedure TForm1.AdvSpreadGrid1ClickCell(Sender: TObject; ARow,ACol: Integer);
var
  State: TKeyboardState;
  Shiftdown:boolean;
  row:integer;
  T1,T2,freq:int64;
  elapsed:integer;
begin
 queryperformancecounter(T1);
 GetKeyboardState(State);
 if processing then
 begin
   button57click(self); showmessage('SoundDB has been Closed');
   processing:=false;
 end;
 shiftdown:= ((State[VK_SHIFT] and 128) <> 0);
 if arow=0 then
 begin
   if Advspreadgrid1.SortSettings.Direction=sdAscending then
     Advspreadgrid1.SortSettings.Direction:=sdDescending
   else Advspreadgrid1.SortSettings.Direction:=sdAscending;
   readingdisk:=true;
   advspreadgrid1.SortSettings.Column:=acol;
   advspreadgrid1.Qsort;
   readingdisk:=false;
   negativeintervalcounter:=0;
 end;
 if (arow>0) and (not shiftdown) then
 begin
   lastrowclicked:=arow;
   if (acol=1) then
    begin
     if checkbox63.checked then
       if (advspreadgrid1.Cells[1, arow]='') then
         begin
           advspreadgrid1.Cells[1, arow]:='Print';
           //addimage(advspreadgrid1.Cells[0, arow]);
         end
       else
           advspreadgrid1.Cells[1, arow]:='';
     if not checkbox63.checked then
       if (advspreadgrid1.Cells[1, arow]='')  then   //and (not zip)
           advspreadgrid1.Cells[1, arow]:='Delete'
     else
           advspreadgrid1.Cells[1, arow]:='' ;
    end
   else
     begin
       overrule:=false;
       if Fileread=true then
         if (arow<>currentrow)  then
          begin
           fileread:=FALSE;
          end
        else
           fileread:=TRUE;

       env_calc:=fileread;
       currentrow:=arow;
       currentcol:=0;
       if advspreadgrid1.cells[0,arow]<>'' then processfile;
       if checkbox62.Checked then smallpreview;
   end;
 end;
 if shiftdown then
 begin
   if acol=1 then
     if advspreadgrid1.Cells[1, lastrowclicked]='' then
        begin
          if lastrowclicked>arow then
              for row:=arow to lastrowclicked do advspreadgrid1.Cells[1, row]:='';
          if lastrowclicked<arow then
              for row:=lastrowclicked to arow do advspreadgrid1.Cells[1, row]:='';
        end
     else
        begin
          if lastrowclicked>arow then
              if checkbox63.checked then
                 for row:=arow to lastrowclicked do
                 begin
                   advspreadgrid1.Cells[1, row]:='Print';
                   //addimage(advspreadgrid1.Cells[0, row]);
                 end
              else
                 for row:=arow to lastrowclicked do
                   begin
                     advspreadgrid1.Cells[1, row]:='Delete';
                   end;

          if lastrowclicked<arow then
             if checkbox63.checked then
                for row:=lastrowclicked to arow do
                begin
                   advspreadgrid1.Cells[1, row]:='Print';
                end
             else
                 for row:=lastrowclicked to arow do
                 begin
                   advspreadgrid1.Cells[1, row]:='Delete';
                 end;
        end;
 end;
 if checkbox29.Checked then
 begin
   queryperformancecounter(T2);
   queryperformancefrequency(freq);
   elapsed:=round(1000*(t2-T1)/freq);
   memo1.Lines.Add(inttostr(elapsed)+' totaltime '+DateTimeToStr(Now));
 end;
end;

procedure TForm1.RadioGroup3Click(Sender: TObject);
begin
    //case radiogroup3.ItemIndex of
    //  0:animator:=rxgifanimator2;
    //  1:animator:=rxgifanimator1;
    //  2:animator:=rxgifanimator3;
    //end;
end;

procedure TForm1.CheckBox33Click(Sender: TObject);
begin
  fileread:=false;
  env_calc:=false;
  //currentrow:=arow;
  //currentcol:=acol;
  processfile;
end;

procedure TForm1.CheckBox34Click(Sender: TObject);
begin
  fileread:=false;
  env_calc:=false;
  //currentrow:=arow;
  //currentcol:=acol;
  processfile;
end;

procedure TForm1.CheckBox35Click(Sender: TObject);
begin
 fileread:=false;
 env_calc:=false;
 processfile;
end;

procedure TForm1.Button25Click(Sender: TObject);
begin
 fileread:=false;
 env_calc:=false;
 overrule:=true;
 processfile;
end;

procedure TForm1.Button26Click(Sender: TObject);
var shiftsize:double;
begin
   shiftsize:=0.2*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit13.value:=rxspinedit13.value-shiftsize;
   rxspinedit12.value:=rxspinedit12.value+shiftsize;
   recalcsonogram:=true;
   env_calc:=false;
   if fileread then processfile;
end;

procedure TForm1.Button27Click(Sender: TObject);
var windowsize:double;
    shiftsize:double;
begin
   shiftsize:=0.2*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit13.value:=rxspinedit13.value+shiftsize;
   rxspinedit12.value:=rxspinedit12.value-shiftsize;
   recalcsonogram:=true;
   env_calc:=false;
   if fileread then processfile;
end;

{
procedure TForm1.rfjChart1dblclick(Sender: TObject);
var windowsize:double;
    shiftsize:double;
    zoomtarget:integer;
begin

   shiftsize:=0.2*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit13.value:=rxspinedit13.value-shiftsize;
   rxspinedit12.value:=rxspinedit12.value+shiftsize;
   windowsize:=(rxspinedit13.value-rxspinedit12.value);
   zoomtarget:=trunc(strtofloat(form3.label2.caption));
   rxspinedit13.value:=zoomtarget+(windowsize/2);
   rxspinedit12.value:=zoomtarget-(windowsize/2);
   button14click(self);

end;
}

procedure TForm1.Button28Click(Sender: TObject);
var result:boolean;
    outstring:string;
begin
  Button15Click(self);
  outstring:=copy(ExtractFileName(currentfile),1,length(currentfile)-4)+'_FIXED.wav';
  result:=windows.copyfile(pchar('$$$.wav'),pchar(outstring),false);
  if result then showmessage('Succes!') else showmessage('Error!');
end;

procedure TForm1.rfjChart2mousedown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 //if (not rfjchart2.doscroll) then
 begin
    //(floattostrf(xoffset+gatetime,fffixed,12,2))
    mouseisdown:=true;
    mousedownx:=x;
    if rfjchart2.DoScroll then mousedownx:=x+trunc(rfjchart2.chart.HScroll.position);
    mousedowny:=y;
    //zoomymin:=round(rfjchart2.ypos2val(mouseupx,mouseupx));
    if Button=mbright then
    begin
      form3.xoffset[rfjchart2.getchannel(x,y)]:=rfjchart2.xpos2val(x,y);
      case points_at_trace of
        1:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Wave';
        2:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Sonogram';
        3:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Envelope';
        4:advstringgrid2.Cells[form3.currentcol+1,form3.currentrow]:='Gate';
      end;
      advstringgrid2.Cells[form3.currentcol+2,form3.currentrow]:='ZERO';
      advstringgrid2.Cells[form3.currentcol+3,form3.currentrow]:=floattostrf(rfjchart2.xpos2val(x,y),ffgeneral,6,2);
      if form3.CheckBox1.Checked then inc(form3.currentrow);
      if form3.currentrow>advstringgrid2.rowcount then advstringgrid2.rowcount:=advstringgrid2.rowcount+1;
      advstringgrid2.row:=advstringgrid2.rowcount-1;
      advstringgrid2.Col:=4;
    end;
    if (toolwindow976.visible) and (rfjchart2.getchannel(x,y)=schannel) then
       if (x>rfjchart2.trace[1].yleft) and (x<rfjchart2.trace[1].yright) then spectrum(x,y);
 end;
end;

{
procedure TForm1.rfjChart1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
    mouseupx:=x;
    mouseupy:=y;
    if (abs(mousedownx-mouseupx)>5) or (mousedowny<>mouseupy) and (button=mbleft) then
    begin
       if mousedownx<mouseupx then
       begin
        rxspinedit13.value:=rfjchart1.xpos2val(mouseupx,mouseupx);
        rxspinedit12.value:=rfjchart1.xpos2val(mousedownx,mousedowny);
        if rfjchart1.getchannel(x,y)=1 then
        begin
          zoomymax:=round(rfjchart1.ypos2val(mouseupx,mouseupx));
          if Zoomymax>zoomymin then
          begin
             //autoupdate:=false;
             //scrollbar2.Position:=zoomymax;
             //autoupdate:=true;
          end;
          if zoomymax<zoomymin then
          begin
             //scrollbar2.Position:=zoomymin;
          end;
        end;
        button14click(self);
       end;
       if mousedownx>mouseupx then
       begin
        rxspinedit12.value:=rfjchart1.xpos2val(mouseupx,mouseupy);
        rxspinedit13.value:=rfjchart1.xpos2val(mousedownx,mousedowny);
        button14click(self);
       end;
    end;
end;
}

procedure TForm1.Button29Click(Sender: TObject);
var pagepar:array[1..32] of Tprintpar;
    pppage:integer;
begin
 if checkbox28.Checked then  rxgifanimator4.Show;
 statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
 pppage:=strtoint(radiogroup4.Items[radiogroup4.ItemIndex]);
 inc(pageprint);
 if ((pageprint=1) and printersetupdialog1.Execute) or (pageprint>1) then
 begin
  if pppage=2 then
  begin
     pagepar[1].mag:=0.85;
     pagepar[1].xoffset:=0.;
     pagepar[1].yoffset:=-0.25;

     pagepar[2].mag:=0.85;
     pagepar[2].xoffset:=0;
     pagepar[2].yoffset:=0.25;

  end;
  if pppage=4 then
  begin
     pagepar[1].mag:=0.47;
     pagepar[1].xoffset:=-0.25;
     pagepar[1].yoffset:=-0.25;

     pagepar[2].mag:=0.47;
     pagepar[2].xoffset:=0.25;
     pagepar[2].yoffset:=-0.25;

     pagepar[3].mag:=0.47;
     pagepar[3].xoffset:=0.25;
     pagepar[3].yoffset:=0.25;

     pagepar[4].mag:=0.47;
     pagepar[4].xoffset:=-0.25;
     pagepar[4].yoffset:=0.25;
   end;
   if pppage=6 then        begin
     pagepar[1].mag:=0.3;
     pagepar[1].xoffset:=-0.25;
     pagepar[1].yoffset:=-0.3;

     pagepar[2].mag:=0.3;
     pagepar[2].xoffset:=-0.25;
     pagepar[2].yoffset:=-0;

     pagepar[3].mag:=0.3;
     pagepar[3].xoffset:=-0.25;
     pagepar[3].yoffset:=0.3;

     pagepar[4].mag:=0.3;
     pagepar[4].xoffset:=0.25;
     pagepar[4].yoffset:=-0.3;

     pagepar[5].mag:=0.3;
     pagepar[5].xoffset:=0.25;
     pagepar[5].yoffset:=-0;

     pagepar[6].mag:=0.3;
     pagepar[6].xoffset:=0.25;
     pagepar[6].yoffset:=0.3;
   end;
   if pppage=8 then
   begin
     pagepar[1].mag:=0.45;
     pagepar[1].xoffset:=-0.25;
     pagepar[1].yoffset:=-0.375;

     pagepar[2].mag:=0.45;
     pagepar[2].xoffset:=-0.25;
     pagepar[2].yoffset:=-0.125;

     pagepar[3].mag:=0.45;
     pagepar[3].xoffset:=-0.25;
     pagepar[3].yoffset:=0.125;

     pagepar[4].mag:=0.45;
     pagepar[4].xoffset:=-0.25;
     pagepar[4].yoffset:=0.375;

     pagepar[5].mag:=0.45;
     pagepar[5].xoffset:=0.25;
     pagepar[5].yoffset:=0.375;

     pagepar[6].mag:=0.45;
     pagepar[6].xoffset:=0.25;
     pagepar[6].yoffset:=0.125;

     pagepar[7].mag:=0.45;
     pagepar[7].xoffset:=0.25;
     pagepar[7].yoffset:=-0.125;

     pagepar[8].mag:=0.45;
     pagepar[8].xoffset:=0.25;
     pagepar[8].yoffset:=-0.375;
   end;
   if pppage=16 then
   begin
     pagepar[1].mag:=0.24;
     pagepar[1].xoffset:=-0.375;
     pagepar[1].yoffset:=-0.375;

     pagepar[2].mag:=0.24;
     pagepar[2].xoffset:=-0.125;
     pagepar[2].yoffset:=-0.375;

     pagepar[3].mag:=0.24;
     pagepar[3].xoffset:=0.125;
     pagepar[3].yoffset:=-0.375;

     pagepar[4].mag:=0.24;
     pagepar[4].xoffset:=0.375;
     pagepar[4].yoffset:=-0.375;

     //

     pagepar[5].mag:=0.24;
     pagepar[5].xoffset:=-0.375;
     pagepar[5].yoffset:=-0.125;

     pagepar[6].mag:=0.24;
     pagepar[6].xoffset:=-0.125;
     pagepar[6].yoffset:=-0.125;

     pagepar[7].mag:=0.24;
     pagepar[7].xoffset:=0.125;
     pagepar[7].yoffset:=-0.125;

     pagepar[8].mag:=0.24;
     pagepar[8].xoffset:=0.375;
     pagepar[8].yoffset:=-0.125;

     //
     pagepar[9].mag:=0.24;
     pagepar[9].xoffset:=-0.375;
     pagepar[9].yoffset:=0.375;

     pagepar[10].mag:=0.24;
     pagepar[10].xoffset:=-0.125;
     pagepar[10].yoffset:=0.375;

     pagepar[11].mag:=0.24;
     pagepar[11].xoffset:=0.125;
     pagepar[11].yoffset:=0.375;

     pagepar[12].mag:=0.24;
     pagepar[12].xoffset:=0.375;
     pagepar[12].yoffset:=0.375;

     //

     pagepar[13].mag:=0.24;
     pagepar[13].xoffset:=-0.375;
     pagepar[13].yoffset:=0.125;

     pagepar[14].mag:=0.24;
     pagepar[14].xoffset:=-0.125;
     pagepar[14].yoffset:=0.125;

     pagepar[15].mag:=0.24;
     pagepar[15].xoffset:=0.125;
     pagepar[15].yoffset:=0.125;

     pagepar[16].mag:=0.24;
     pagepar[16].xoffset:=0.375;
     pagepar[16].yoffset:=0.125;
   end;
  end;
   //
  if pageprint=1 then
     begin
       if pppage=2 then printer.orientation:=poportrait;
       if pppage=8 then printer.orientation:=poportrait;
       if pppage=6 then printer.orientation:=polandscape;
       if pppage=16 then printer.orientation:=polandscape;
       printer.begindoc;
     end;
     form5.show;
     form5.label2.caption:='FINISHED '+inttostr(pageprint)+ ' of '+inttostr(pppage);
     rfjchart1.drawmode:=dmline;
     if pppage>2 then rfjchart1.printer_setsmallfont:=true;
     {
     rfjchart1.printmag:=rxspinedit15.Value/100;
     rfjchart1.printmag:=pagepar[pageprint].mag;
     rfjchart1.printeryoffset:=pagepar[pageprint].yoffset;
     rfjchart1.printerxoffset:=pagepar[pageprint].xoffset;
     rfjchart1.getprinterpar;
     rfjchart1.printerdrawaxes;
     rfjchart1.printer_trace[1].clipy:=true;
     rfjchart1.printerdrawbuffer;
     }
     sleep(2);
     if pageprint=pppage then
     begin
       printer.enddoc;
       pageprint:=0;
       form5.hide
     end;

   rxgifanimator4.hide;
   statusbar1.Panels[4].Text:='';statusbar1.Update;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var Globalmemoryinfo:Tmemorystatus;
    Ram,Swap:integer;
    pmc: TProcessMemoryCounters;
    memoryusage:cardinal;
Begin
   pmc.cb := SizeOf(pmc) ;
   if GetProcessMemoryInfo(GetCurrentProcess, @pmc, SizeOf(pmc)) then
       memoryusage := pmc.WorkingSetSize
   else
       RaiseLastOSError;

  Globalmemoryinfo.dwlength:=Sizeof(Globalmemoryinfo);
  Globalmemorystatus(Globalmemoryinfo);
  Ram:=100-round(100*(globalmemoryinfo.dwavailphys/globalmemoryinfo.dwtotalphys));
  Swap:=100-round(100*(globalmemoryinfo.dwavailpagefile/globalmemoryinfo.dwtotalpagefile));
  statusbar1.Panels[0].Text:='TOTALRAM '+inttostr(Ram)+'%';
  statusbar1.Panels[1].Text:='TOTALSWAP '+inttostr(swap)+'%';
  statusbar1.Panels[2].Text:=FormatFloat('USED: ,.# Kb', MemoryUsage / 1024);
  statusbar1.Update;
  form1.Update;
end;


procedure TForm1.Panel15GetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
 CanDock:=Dockclient.Tag=1;
end;

procedure TForm1.Panel12GetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
 CanDock:=Dockclient.Tag=2;
end;

procedure TForm1.Panel3GetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
 CanDock:=Dockclient.Tag=3;
end;

procedure TForm1.Panel3DockDrop(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer);
begin
  panel1.align:=alright;
  //panel3.width:=141;
  panel1.align:=alclient;
end;

procedure TForm1.Panel3UnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
 //panel3.width:=1;
end;

procedure TForm1.Panel12UnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
   //panel12.width:=1;
end;

procedure TForm1.Panel12DockDrop(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer);
begin
 //panel12.Width:=250;
end;

procedure TForm1.Panel17GetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
   CanDock:=Dockclient.Tag=4;
end;

procedure TForm1.RxSpinEdit19Change(Sender: TObject);
begin
 if checkbox12.Checked then
 begin
   if checkbox47.Checked then aho_sonogram2 else sonogram2;
   rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.trace[wchannel].ygmax:=slide2[wchannel].Position;
   rfjchart2.trace[wchannel].ygmin:=-(rfjchart2.trace[wchannel].ygmax);
   rfjchart2.backcolor:=clwhite;
   rfjchart2.keepdata:=true;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.update;
 end;
end;

procedure TForm1.Settings1Click(Sender: TObject);
begin
 //panel2.Show;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  //spectrumcorrelationmap;


end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 panel8.Show;
end;

procedure TForm1.OpenWavZip1Click(Sender: TObject);
begin
 savebitmaps:=false;
 opendialog1.Filter:='WAV & ZIP Files|*.WAV;*.ZIP';
 advspreadgrid1.Clear;
 readfiles;
 //toolwindow9715.show;
 //form6.Show;
end;

procedure TForm1.OpenCSVWAV1Click(Sender: TObject);
var i:integer;
begin
  FromCSV:=false;
  if opendialog2.execute then
  begin
     advspreadgrid1.rowcount:=2;
     advspreadgrid1.row:=1;
     statusbar1.Panels[5].Text:=opendialog2.filename;
     Filepath:=PathWithoutRightElement(form1.opendialog2.filename,'\');
     path:=Filepath;
     advspreadgrid1.LoadFromCSV(opendialog2.filename);
     zip:=false;
     FromCSV:=true;
     fitlist;
     //toolwindow9715.show;
     //fix?
     //for i:=1 to  advspreadGrid1.rowcount-1 do
     //begin
     //    advspreadgrid1.Cells[2,i-1]:=inttostr(trunc(strtofloat(advspreadgrid1.Cells[3,i-1])));
     //end;
  end;
end;

procedure TForm1.Exit1Click(Sender: TObject);
var i:integer;
begin
 application.Minimize;
 //SetThreadpriority(GetcurrentThread,THREAD_PRIORITY_BELOW_NORMAL);


 timer1.Enabled:=false;
 deletefile('$$$.wav');
 deletefile('wavcount.wav');
 deletefile('soundimages.db');
 colors.free;
 PNG.free;
 fbmp2.free;
 idbbmp.free;

 for i:=0 to maxclusters do showbmp[i].free;

 AdvSpreadGrid1.RowCount:=0;
 AdvStringGrid2.RowCount:=0;
 AdvStringGrid1.RowCount:=0;

 setlength(tempwav,0);
 setlength(wavdata,0);
 setlength(ebuffer,0);
 setlength(idbimg,0);
 setlength(bit,0);
 setlength(kmeans1.iwork,0);
 setlength(kmeans1.iscore,0);
 setlength(dumdata,0);
 setlength(kmeans1.sum,0);
 setlength(areatrack,0);
 setlength(clusterinfo,0);

 //form16.AdvSpreadGrid1.RowCount:=0;
 //form17.AdvSpreadGrid1.RowCount:=0;
 //form19.AdvStringGrid1.RowCount:=0;
 form21.AdvSpreadGrid1.RowCount:=0;
 form22.AdvSpreadGrid1.RowCount:=0;
 form24.AdvSpreadGrid1.RowCount:=0;
 form26.AdvSpreadGrid1.RowCount:=0;

 for i:=1 to 4 do
 begin
    slide[i].free;
    slide2[i].free;
    slidepanel[i].free;
    slidepanel2[i].free;
 end;

 setlength(dumdata,0);
 setlength(dumdata2,0);

 //application.Terminate;
 //halt(0);
 TerminateProcess( getCurrentProcess, 0 );
 //application.free;

end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  if checkbox12.checked then
  begin
   if checkbox47.Checked then aho_sonogram2 else sonogram2;
   rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.trace[wchannel].ygmax:=slide2[wchannel].Position;
   rfjchart2.trace[wchannel].ygmin:=-(rfjchart2.trace[wchannel].ygmax);
   rfjchart2.backcolor:=clwhite;
   rfjchart2.keepdata:=true;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.update;
   if checkbox46.checked then
   begin
          env_calc:=false;
          chart2;
   end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  //samplesperbin:=rxspinedit4.value*(rate/1000); // needed for sonogram alignment;
  samplesperbin:=strtoint(combobox1.Items.strings[combobox1.ItemIndex]);
  if checkbox12.checked then
  begin
   if checkbox47.Checked then aho_sonogram2 else sonogram2;
   rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.trace[wchannel].ygmax:=slide2[wchannel].Position;
   rfjchart2.trace[wchannel].ygmin:=-(rfjchart2.trace[wchannel].ygmax);
   rfjchart2.backcolor:=clwhite;
   rfjchart2.keepdata:=true;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.update;
   if checkbox46.checked then
   begin
          env_calc:=false;
          chart2;
   end;
  end;
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
 showfilterkar;
end;

procedure TForm1.Button4Click(Sender: TObject);
var i:integer;
    filesize:string;
    minsize,maxsize:integer;
    sr: TSearchRec;
    FileAttrs: Integer;
    arg1,arg2:string;
    filename:string;
    fileinfo:string;
    zipdir:string;
    testsize:integer;
    temp:double;
    top:double;
    hrs,min,sec,timestring:string;
    totalsize,donesize:int64;
    freq,starttime,donetime,totaltime,lefttime:int64;
    speed,speed2:double;
    smallbmp:Tbitmap32;
    procspeed:integer;
    looptime:int64;
    oneloop:double;
    elapsed:double;
    result:boolean;
    name:string;
begin
 prevsyltime:=0;
 
 memo4.Clear;
 advspreadgrid1.SortSettings.Column:=4;
 advspreadgrid1.SortSettings.Direction:=sdAscending;
 advspreadgrid1.QSort;

 //checkbox66.Checked :=false;

 pagecontrol1.activepage:= Tabsheet2; application.ProcessMessages;
 if checkbox28.Checked then rxgifanimator4.Show;
 statusbar1.Panels[4].Text:='W O R K I N G';statusbar1.Update;
 stop:=false;
 form1.StartHPfilter;
 path:=PathWithoutRightElement(form1.opendialog1.filename,'\');
 minsize:=44+trunc(rxspinedit1.value*rate*2);
 maxsize:=44+trunc(rxspinedit39.value*rate*2);
 //label60.caption:=inttostr(minsize);
 //label61.caption:=inttostr(maxsize);
 if checkbox50.Checked then
 BEGIN
   Try
      mynewfilename := 'soundimages.db';
      FFile := TFileStream.Create(mynewfilename,fmCreate);
   finally
   end;
 END;
 //get the total size of all the files from the spreadgrid
 totalsize:=0;
 ptotalcount:=0;
 printcount:=advspreadgrid1.RowCount;
 for i:=1 to advspreadGrid1.rowcount-1 do
 begin
     testsize:=strtoint(advspreadGrid1.cells[2,i]);
     if (testsize>=minsize) and (testsize<=maxsize) then
     begin
       totalsize:=totalsize+testsize;
       inc(ptotalcount);
       if checkbox62.checked then
       begin
         sumlist[ptotalcount]:= advspreadgrid1.Cells[0,i];
         sumlistlookup[ptotalcount]:=i;
       end;
     end;
 end;

 if checkbox62.checked then
 begin
  prr:=trunc(rxspinedit41.value);
  pcc:=trunc(rxspinedit45.value);
  smallbmp:=Tbitmap32.Create;
  smallbmp.setsize(prr,pcc);
  pcols:=trunc(rxspinedit46.value);
  prow:=1;pcol:=0;
  pbcols:=pcols*(prr+5);
  pbrows:=ceil(pTOTALCOUNT/pCOLS)*(pcc+5)    ;
  imgview322.Bitmap.SetSize(5+pbcols,5+pbrows);
  imgview322.Bitmap.Clear(clwhite32);
 end;


 gauge1.MinValue:=0;
 gauge1.MaxValue:=100;
 donesize:=0;
 queryperformancecounter(starttime);
 queryperformancefrequency(freq);
 //fromfile:=path+'\'+advspreadGrid1.Cells[0,1]+'.wav';
 //tofile:='c:\temp\next.wav';
 //copyfile(pchar(fromfile),pchar(tofile),false);

 if not savebitmaps then
 begin
  assignfile(idb,filepath+'\'+'images.db');
  rewrite(idb,1);
  idb_written:=0;
  assignfile(spec,filepath+'\'+'spectra.dat');
  rewrite(spec,sizeof(specdata));
  assignfile(specf,filepath+'\'+'spectra.daf');
  rewrite(specf,sizeof(specdataf));
  speccols:=false;
  spec_written:=0;
 end;

 begin
    /////////////////////////////////////////////////////////////////
    for i:=1 to advspreadGrid1.rowcount-1 do
    begin
      AdvSpreadGrid1.ScrollInView(0,i);
      AdvSpreadGrid1.SelectRows(i,1);
      AdvSpreadGrid1.update;
      currentrow:=i; ///rfj maart 12 2004
      queryperformancecounter(looptime);
      fileread:=false;
      env_calc:=false;
      recalcsonogram:=true;
      filefiltered:=false;
      application.processmessages;
      if stop then break ;
      if ((radiogroup1.itemindex=2) and (checkbox3.Checked)) then mediaplayer1.Close;
      ///////////////////////////////////////////////////////////////////////
      //deletefile('c:\temp\wavcount.wav');
      //result:=false;
       //while not result do
      //   result:=copyfile(pchar('c:\temp\next.wav'),pchar('c:\temp\wavcount.wav'),false);
      //   //result:=renamefile('c:\temp\next.wav','c:\temp\wavcount.wav');
      //
      //fromfile:=path+'\'+advspreadGrid1.Cells[0,i+1]+'.wav';
      //tofile:='c:\temp\next.wav';
      //JvThread1.Execute(self);
      ///////////////////////////////////////////////////////////////////////
      opendialog1.filename:=advspreadGrid1.Cells[0,i]+'.wav';
      currentfile:=opendialog1.filename;
      filesize:=advspreadgrid1.Cells[2, i];
      ///////////////////////////////////////////////////////////////////////
      if zip then
      begin
        //if not DirectoryExists('c:\temp') then
        //  if not CreateDir('C:\temp') then
        //    raise Exception.Create('Cannot create c:\temp');
        opendialog1.FileName:='wavcount.wav';
        path:=PathWithoutRightElement(form1.opendialog1.filename,'\');
        if filesize<>'' then
        begin
         testsize:=strtoint(filesize);
         if (testsize>=minsize) and (testsize<=maxsize) then
         begin
          ZipMaster1.ZipFileName:=form1.zipfilename;
          Zipdir:=extractfilepath(form1.zipfilename);
          ZipMaster1.FSpecArgs.Clear;
          arg1:=advspreadgrid1.Cells[5, i];
          arg2:=advspreadgrid1.Cells[0, i];
          ZipMaster1.FSpecArgs.Add(arg1+arg2);
          statusbar1.Panels[5].text:=arg2;
          setcurrentdir('');
          try
            ZipMaster1.Extract;
            deletefile('wavcount.wav');
            renamefile(''+advspreadgrid1.Cells[0,i],'c:\temp\wavcount.wav');
          except
            ShowMessage( 'Error in Extract; Fatal DLL Exception in mainunit' );
          end;
         end;
        end;
      end;
      //////////////////////////////////////////////////////////////
      if filesize<>'' then
      begin
       testsize:=strtoint(filesize);
       if (testsize>=minsize) and (testsize<=maxsize) then
       begin
        showwave;
        if checkbox10.Checked then filter;
        if checkbox8.checked then
        begin
            count;
            advspreadgrid1.Cells[3,i]:=label1.caption;
        end;
        if checkbox9.checked then
        begin
            count2;
            advspreadgrid1.Cells[4,i]:=label1.caption;
        end;
        if checkbox50.Checked then
        begin
            processing:=true;
            env_calc:=false;
            recalcsonogram:=true;
            chart2;
            application.ProcessMessages;
            Button54Click(self);
        end;
        if checkbox2.Checked then
        begin
           chart2;
           name:=PathWithoutRightElement(form1.opendialog1.filename,'.');
           if savebitmaps then fbmp2.SaveToFile(name+'.bmp');
           if checkbox62.checked then
           begin
              inc(pcol);
              if pcol>pcols then
              begin
                  pcol:=1;
                  inc(prow);
              end;
              case combobox7.itemindex of
               0: rfjchart2.bmp.StretchFilter:=sfnearest;
               1: rfjchart2.bmp.StretchFilter:=sflinear;
               2: rfjchart2.bmp.StretchFilter:=sfSpline;
               3: rfjchart2.bmp.StretchFilter:=sfLanczos;
               4: rfjchart2.bmp.StretchFilter:=sfMitchell;
              end;
              rfjchart2.bmp.DrawTo(smallbmp,rect(0,0,smallbmp.Width-1,smallbmp.height-1));
              smallbmp.DrawTo(imgview322.bitmap,(5+(pcol-1)*(prr+5)),(5+(prow-1)*(pcc+5)));
              imgview322.Bitmap.Font.Color:=clred;
              imgview322.Bitmap.Textout(5+(pcol-1)*(prr+5),5+(prow-1)*(pcc+5),advspreadgrid1.Cells[0,i]);
           end;
        end;
        if checkbox3.Checked then
        begin
         mediaplayer1.FileName:=opendialog1.FileName;
         mediaplayer1.open;
         play;
         SLEEP(TRUNC(1000*Nofsamples/(nofchannels*rate)))
        end;

        if checkbox73.Checked then
        begin
             save_bin:=true;
             application.ProcessMessages;
             echannel_leftscroll_change(self);
             application.ProcessMessages;
             save_bin:=false;
        end;

        if i=1 then fitlist;
        donesize:=donesize+testsize;
        queryperformancecounter(donetime);
        speed:=donesize/(donetime-starttime);
        lefttime:=round((totalsize-donesize)/speed);
        ///
        oneloop:=1000000*(donetime-looptime)/freq; //microsec;
        speed2:=testsize/oneloop;  //bytes/microsec
        //
        elapsed:=1000000*(donetime-starttime)/freq;
        speed:=donesize/elapsed;
        label74.Caption:='Mean ='+floattostrf(speed,ffgeneral,3,2)+'             ';
        label73.Caption:='Speed='+floattostrf(speed2,ffgeneral,3,2)+'             ';
        if lefttime>(60*freq) then
            label64.Caption:='Time Left is about '+inttostr(ceil(lefttime/(60*freq)))+' minutes'+'             '
        else
            label64.Caption:='Time Left is about '+inttostr(ceil(lefttime/freq))+' seconds'+'             ';

        gauge1.Progress:=trunc(100*(donesize/totalsize));
       end;
       memo4.Lines.Add(currentfile+' '+label87.caption+' '+label88.caption);
     end;
    end;
   end;

   if checkbox73.Checked and (Label88.caption<>label87.Caption) then
                                            ShowMessage('Error Processing DB/DAT/DAF (Unequal number of records)');

   if negativeintervalcounter>0  then
   begin
         showmessage('ALERT: '+inttostr(negativeintervalcounter)+' NEGATIVE INTERVALS FOUND !!!');
         negativeintervalcounter:=0;
   end;

   processing:=false;
   if checkbox50.Checked then FFile.free;
   imagefileisopen:=false;

   if not savebitmaps then
   begin
     FlushFileBuffers(TFileRec(idb).Handle);
     closefile(idb);
     FlushFileBuffers(TFileRec(spec).Handle);
     closefile(spec);
     FlushFileBuffers(TFileRec(specf).Handle);
     closefile(specf);
   end;

   //savedialog1.filename:=copy(ZipMaster1.ZipFileName,1,length(ZipMaster1.ZipFileName)-3)+'CSV';
   //if savedialog1.execute then advspreadgrid1.SaveToCSV(Savedialog1.filename+'.CSV');

   imgview322.update;
   smallbmp.Free;
   rxgifanimator4.hide;
   statusbar1.Panels[4].Text:='';statusbar1.Update;
end;



procedure TForm1.OpwnCSVZIP1Click(Sender: TObject);
var i:integer;
begin
  FromCSV:=false;
  if opendialog2.execute then
  begin
     advspreadgrid1.rowcount:=1;
     statusbar1.Panels[5].Text:=opendialog2.filename;
     Filepath:=PathWithoutRightElement(form1.opendialog2.filename,'\');
     path:=Filepath;
     advspreadgrid1.LoadFromCSV(opendialog2.filename);
     zip:=true;
     FromCSV:=true;
     //toolwindow9715.show;
     //fix?
     //for i:=1 to  advspreadGrid1.rowcount-1 do
     //begin
     //    advspreadgrid1.Cells[2,i-1]:=inttostr(trunc(strtofloat(advspreadgrid1.Cells[3,i-1])));
     //end;
  end;
end;


procedure TForm1.rfjChart2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  var trace:integer;
begin
 mouseisdown:=false;
 trace:=rfjchart2.getchannel(x,y);
 if not ((checkbox72.Checked) and (trace=4)) then
  if (not rfjchart2.doscroll) then
  begin
    mouseisdown:=false;
    mouseupx:=x;
    mouseupy:=y;
    if (abs(mousedownx-mouseupx)>5) or (mousedowny<>mouseupy) and (button=mbleft) then
    begin
       if mousedownx<mouseupx then
       begin
        rxspinedit13.value:=rfjchart2.xpos2val(mouseupx,mouseupx);
        rxspinedit12.value:=rfjchart2.xpos2val(mousedownx,mousedowny);
        recalcsonogram:=true;
        if rfjchart2.getchannel(x,y)=1 then
        begin
          zoomymax:=round(rfjchart2.ypos2val(mouseupx,mouseupx));
          if Zoomymax>zoomymin then
          begin
             //autoupdate:=false;
             //scrollbar2.Position:=zoomymax;
             //autoupdate:=true;
          end;
          if zoomymax<zoomymin then
          begin
             //scrollbar2.Position:=zoomymin;
          end;
        end;
        button14click(self);
       end;
       if mousedownx>mouseupx then
       begin
        rxspinedit12.value:=rfjchart2.xpos2val(mouseupx,mouseupy);
        rxspinedit13.value:=rfjchart2.xpos2val(mousedownx,mousedowny);
        button14click(self);
       end;
    end;
  end;
end;

procedure TForm1.rfjChart3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
{
    mouseupx:=x;
    mouseupy:=y;
    if (abs(mousedownx-mouseupx)>5) or (mousedowny<>mouseupy) and (button=mbleft) then
    begin
       if mousedownx<mouseupx then
       begin
        rxspinedit13.value:=rfjchart3.xpos2val(mouseupx,mouseupx);
        rxspinedit12.value:=rfjchart3.xpos2val(mousedownx,mousedowny);
        if rfjchart3.getchannel(x,y)=1 then
        begin
          zoomymax:=rfjchart3.ypos2val(mouseupx,mouseupx);
          if Zoomymax>zoomymin then
          begin
             //autoupdate:=false;
             //scrollbar2.Position:=zoomymax;
             //autoupdate:=true;
          end;
          if zoomymax<zoomymin then
          begin
             //scrollbar2.Position:=zoomymin;
          end;
        end;
        button14click(self);
       end;
       if mousedownx>mouseupx then
       begin
        rxspinedit12.value:=rfjchart3.xpos2val(mouseupx,mouseupy);
        rxspinedit13.value:=rfjchart3.xpos2val(mousedownx,mousedowny);
        button14click(self);
       end;
    end;
}
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  advstringgrid2.Clear;
  form3.currentrow:=0;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  play;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[1];
 //Toolwindow971.Show;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
Toolwindow9713.Show;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[4];
 //toolwindow973.Show;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[2];
//toolwindow974.Show;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[3];
 //    toolwindow975.show;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
    toolwindow976.show;
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[5];
 //toolwindow978.show;
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
 memo1.Clear;
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[7];
 // toolwindow979.Show;
end;

procedure TForm1.BitBtn12Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[0];
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
begin
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[6];
 //toolwindow9711.Show;
end;

procedure TForm1.BitBtn14Click(Sender: TObject);
begin
  if savedialog4.execute then advstringgrid2.SaveToCSV(savedialog4.FileName);
end;

procedure TForm1.BitBtn15Click(Sender: TObject);
begin
  advstringgrid2.CopyToClipBoard;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
 jvwaveplayer1.FileName:='$$$.wav';
 jvwaveplayer1.Play;
end;

procedure TForm1.PlayAll1Click(Sender: TObject);
begin
//play;
end;

procedure TForm1.PalySelection1Click(Sender: TObject);
begin
 jvwaveplayer1.FileName:='$$$.wav';
 jvwaveplayer1.Play;
end;

procedure TForm1.Print2Click(Sender: TObject);
begin
 //toolwindow9710.Show;
end;

procedure Tform1.ReadFiles;
var  i,j:integer;
     datmedian:smallint;
     testdata:int64array;
     rmed:integer;
     ext:string;
     sr:Tsearchrec;
     read:integer;
     minutes:extended;
     seconds:extended;
     maxfilenamelength:array[0..10] of integer;
     testwidth:integer;
     day,month,yr,hrs,min,sec,timestring,datestring:string;
     wyear,wday,wmonth,wyr,whrs,wmin,wsec,wmsec:word;
     datetime:Tdatetime;
     secinday,msecinday:int64;
     f1datetime:Tdatetime;
     maand:integer;
     //
     id:integer;
     testchar:char;
     teststring:string;
     testval:byte;
     offset:string;
     woffset:integer;
     ayear,amonth,aday,ahour,aminute,asecond,amillisecond:word ;
     wtimestring:int64;
begin
 readingdisk:=true;
 form3.currentrow:=1;
 form3.currentcol:=1;
 fileread:=false;
 env_calc:=false;
 filefiltered:=false;
 fromCSV:=false;
 numfiles:=0;
 mediaplayer1.Close;
 zip:=false; //default to WAV
 ZipMaster1.ZipFileName:='';
 if opendialog1.execute then
 begin
     deletefile('$$$.wav');
     ext:=copy(opendialog1.filename,length(opendialog1.filename)-2,3);
     if uppercase(ext)='ZIP' then
     begin
       //bitbtn19.Enabled:=false;
       //bitbtn20.Enabled:=false;
       //bitbtn21.Enabled:=false;
       zip:=true;
       zipfilename:=opendialog1.filename;
       ziphome:=PathWithoutRightElement(opendialog1.filename,'\') ;
       zipname:=z_ItemCGetLast(opendialog1.filename,'\');
       ZipMaster1.ZipFileName:=opendialog1.filename;
       statusbar1.Panels[5].Text:=opendialog1.filename;
       getzipfile;
     end;
     if not zip then
     begin
       begin
        advspreadgrid1.Clear;
        advspreadGrid1.Cells[0, 0] := '0-Filename';
        advspreadGrid1.Cells[1, 0] := '1-Status';
        advspreadGrid1.Cells[2, 0] := '2-Size';
        advspreadGrid1.Cells[3, 0] := '3';
        advspreadGrid1.Cells[4, 0] := '4-Time';
        advspreadGrid1.Cells[5, 0] := '5';
        advspreadGrid1.Cells[6, 0] := '6-MsecinDay';
        bitbtn19.Enabled:=true;
        bitbtn20.Enabled:=true;
        Filepath:=PathWithoutRightElement(form1.opendialog1.filename,'\');
        path:=Filepath;
        //application.processmessages;
        if FindFirst(path+'\*.wav', faAnyFile, sr) = 0 then
        begin
         maxfilenamelength[0]:=0;
         maxfilenamelength[2]:=0;
         maxfilenamelength[5]:=0;
         advspreadGrid1.rowcount:=2;
         repeat
          begin
           advspreadGrid1.Cells[0,advspreadGrid1.RowCount-1] := copy(ExtractFileName(sr.name),1,length(sr.name)-4);
           advspreadGrid1.Cells[2,advspreadGrid1.RowCount-1] := IntToStr(sr.Size);
           //application.processmessages;

            //7 underscores if selections of SAP files are made using SE
           if ((z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=7) then
           begin
            //optie 1: het eerste woord na de underscore bevat een letter
            //optie 2: het eerste woord na de underscore bevat GEEN letter
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
            //
            //de string test
            testchar:=timestring[1];
            testval:=ord(testchar);
           // form1.caption:=inttostr(testval);
            if ((testval>64) and (testval<91)) or ((testval>96) and (testval<123)) then
              begin
                  //The second word contains a letter
                  if (timestring<>'') then
                  begin
                    Month:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
                    if uppercase(copy(month,1,3))='JAN' then maand:=1;
                    if uppercase(copy(month,1,3))='FEB' then maand:=2;
                    if uppercase(copy(month,1,3))='MAR' then maand:=3;
                    if uppercase(copy(month,1,3))='APR' then maand:=4;
                    if uppercase(copy(month,1,3))='MAY' then maand:=5;
                    if uppercase(copy(month,1,3))='JUN' then maand:=6;
                    if uppercase(copy(month,1,3))='JUL' then maand:=7;
                    if uppercase(copy(month,1,3))='AUG' then maand:=8;
                    if uppercase(copy(month,1,3))='SEP' then maand:=9;
                    if uppercase(copy(month,1,3))='OCT' then maand:=10;
                    if uppercase(copy(month,1,3))='NOV' then maand:=11;
                    if uppercase(copy(month,1,3))='DEC' then maand:=12;

                    day:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_');
                    year:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],3,3,'_');
                    Hrs:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
                    Min:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],5,5,'_');
                    Sec:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],6,6,'_');

                    wyear:=strtoint(year);
                    wmonth:=maand;
                    wday:=strtoint(day);
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=1000*secinday;
                    advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
                    f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
                    advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(f1datetime);
                  end;
               end
             else
               begin   //The second word does not contain a letter
                  if (timestring<>'') then
                  begin
                    advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
                    Hrs:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
                    Min:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],5,5,'_');
                    Sec:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],6,6,'_');
                    Offset:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],7,7,'_');
                    offset:=z_ItemCGetFmTo(offset,0,0,'-');
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    woffset:=strtoint(offset);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=(1000*secinday)+woffset;
                    advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
                  end;
               end;
            end;
           //FORMAT:
           //7 underscores if selections of SAP files are made using SE
           if ((z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=6)  then
           begin
            //optie 1: het eerste woord na de underscore bevat een letter
            //optie 2: het eerste woord na de underscore bevat GEEN letter
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
            //
            //de string test
            testchar:=timestring[1];
            testval:=ord(testchar);
           // form1.caption:=inttostr(testval);
            if ((testval>64) and (testval<91)) or ((testval>96) and (testval<123)) then
              begin
                  //The second word contains a letter
                  if (timestring<>'') then
                  begin
                    Month:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
                    if uppercase(copy(month,1,3))='JAN' then maand:=1;
                    if uppercase(copy(month,1,3))='FEB' then maand:=2;
                    if uppercase(copy(month,1,3))='MAR' then maand:=3;
                    if uppercase(copy(month,1,3))='APR' then maand:=4;
                    if uppercase(copy(month,1,3))='MAY' then maand:=5;
                    if uppercase(copy(month,1,3))='JUN' then maand:=6;
                    if uppercase(copy(month,1,3))='JUL' then maand:=7;
                    if uppercase(copy(month,1,3))='AUG' then maand:=8;
                    if uppercase(copy(month,1,3))='SEP' then maand:=9;
                    if uppercase(copy(month,1,3))='OCT' then maand:=10;
                    if uppercase(copy(month,1,3))='NOV' then maand:=11;
                    if uppercase(copy(month,1,3))='DEC' then maand:=12;

                    day:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_');
                    year:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],3,3,'_');
                    Hrs:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
                    Min:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],5,5,'_');
                    Sec:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],6,6,'_');

                    wyear:=strtoint(year);
                    wmonth:=maand;
                    wday:=strtoint(day);
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=1000*secinday;
                    advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
                    f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
                    advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(f1datetime);
                  end;
               end
             else
               begin   //The second word does not contain a letter
                  if (timestring<>'') then
                  begin
                    advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
                    Hrs:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
                    Min:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],5,5,'_');
                    Sec:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],6,6,'_');
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=1000*secinday;
                    advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
                    //decodedatetime(strtofloat(timestring),ayear,amonth,aday,ahour,aminute,asecond,amillisecond);
                  end;
               end;
            end;
           //FORMAT: CAGE_DATE_TIME
           //TIME=MSECSFROMMIDNIGHT
           //DATE=MONTH_DAY_YEAR -- JAN_31_2005
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=4 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
            if (timestring<>'') then
            begin
              year:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],3,3,'_');
              month:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
              day:=(z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_'));
              //
              if uppercase(copy(month,1,3))='JAN' then maand:=1;
              if uppercase(copy(month,1,3))='FEB' then maand:=2;
              if uppercase(copy(month,1,3))='MAR' then maand:=3;
              if uppercase(copy(month,1,3))='APR' then maand:=4;
              if uppercase(copy(month,1,3))='MAY' then maand:=5;
              if uppercase(copy(month,1,3))='JUN' then maand:=6;
              if uppercase(copy(month,1,3))='JUL' then maand:=7;
              if uppercase(copy(month,1,3))='AUG' then maand:=8;
              if uppercase(copy(month,1,3))='SEP' then maand:=9;
              if uppercase(copy(month,1,3))='OCT' then maand:=10;
              if uppercase(copy(month,1,3))='NOV' then maand:=11;
              if uppercase(copy(month,1,3))='DEC' then maand:=12;
              //
              whrs:=strtoint(timestring) div 3600000;
              wmin:=(strtoint(timestring)-(whrs*3600000)) div 60000;
              wsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)) div 1000;
              wmsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)-(wsec*1000));
              advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(encodedatetime(strtoint(year),maand,strtoint(day),whrs,wmin,wsec,wmsec));
              advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=timestring;
            end;
           end;

           //FORMAT: CAGE_DATE_TIME_START-STOP //selection file
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=5 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
            if (timestring<>'') then
            begin
              year:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],3,3,'_');
              month:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
              day:=(z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_'));
              Offset:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],5,5,'_');
              offset:=z_ItemCGetFmTo(offset,0,0,'-');
              //
              if uppercase(copy(month,1,3))='JAN' then maand:=1;
              if uppercase(copy(month,1,3))='FEB' then maand:=2;
              if uppercase(copy(month,1,3))='MAR' then maand:=3;
              if uppercase(copy(month,1,3))='APR' then maand:=4;
              if uppercase(copy(month,1,3))='MAY' then maand:=5;
              if uppercase(copy(month,1,3))='JUN' then maand:=6;
              if uppercase(copy(month,1,3))='JUL' then maand:=7;
              if uppercase(copy(month,1,3))='AUG' then maand:=8;
              if uppercase(copy(month,1,3))='SEP' then maand:=9;
              if uppercase(copy(month,1,3))='OCT' then maand:=10;
              if uppercase(copy(month,1,3))='NOV' then maand:=11;
              if uppercase(copy(month,1,3))='DEC' then maand:=12;
              //
              woffset:=strtoint(offset);
              wtimestring:=strtoint(timestring)+woffset;
              timestring:=inttostr(wtimestring);
              whrs:=strtoint(timestring) div 3600000;
              wmin:=(strtoint(timestring)-(whrs*3600000)) div 60000;
              wsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)) div 1000;
              wmsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)-(wsec*1000));
              advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(encodedatetime(strtoint(year),maand,strtoint(day),whrs,wmin,wsec,wmsec));
              advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=timestring;
            end;
           end;
           //FORMAT: CAGE_TIME_DATE
           //TIME=HHMMSS
           //DATE=DDMMYY
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=2 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
            datestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_');
            if (timestring<>'') and (datestring <>'') then
            begin
              Hrs:=z_SMiddle(Timestring,1,2);
              Min:=z_SMiddle(Timestring,3,2);
              Sec:=z_SMiddle(Timestring,5,2);
              day:=z_SMiddle(datestring,1,2);
              month:=z_SMiddle(datestring,3,2);
              year:=z_SMiddle(datestring,5,2);
              //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=inttostr(strtoint(sec)+(60*strtoint(min))+(3600*strtoint(hrs)));
              //
              wyear:=2000+ strtoint(year);
              wmonth:=strtoint(month);
              wday:=strtoint(day);
              whrs:=strtoint(hrs);
              wmin:=strtoint(min);
              wsec:=strtoint(sec);
              secinday:=(3600*whrs)+(60*wmin)+wsec;
              msecinday:=1000*secinday;
              advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
              f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
              advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(f1Datetime);
              //datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
              //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(Datetime);
            end;
           end;

           //FORMAT : CAGE_TIME
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=1 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
            if timestring<>'' then
            begin
              advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=timestring;
            end;
           end;

           if (advspreadGrid1.Cells[6, advspreadGrid1.RowCount-1]='') or (advspreadGrid1.Cells[4, advspreadGrid1.RowCount-1]= '') then Showmessage('Unrecognized  Format Filename');
           advspreadGrid1.RowCount := advspreadGrid1.RowCount + 1;


          end;
         until FindNext(sr) <> 0;

        advspreadGrid1.RowCount := advspreadGrid1.RowCount-1;
        advspreadGrid1.update;
       end;
       end;
       //currentfile:=opendialog1.filename;
       advstringgrid1.Row := 1;
       currentrow:=1;
       processfile ;
     end;
  end;
  //fileread:=false;
  label55.caption:=inttostr(advspreadgrid1.RowCount)+' Files';
  readingdisk:=false;
  fitlist;
  //application.processmessages;
  //toolwindow9715.Show;
end;

procedure Tform1.ReadFilesAuto;
var  i,j:integer;
     datmedian:smallint;
     testdata:int64array;
     rmed:integer;
     ext:string;
     sr:Tsearchrec;
     read:integer;
     minutes:extended;
     seconds:extended;
     maxfilenamelength:array[0..10] of integer;
     testwidth:integer;
     day,month,yr,hrs,min,sec,timestring,datestring:string;
     wyear,wday,wmonth,wyr,whrs,wmin,wsec:word;
     datetime:Tdatetime;
     secinday,msecinday:int64;
     f1datetime:Tdatetime;
begin
 readingdisk:=true;
 form3.currentrow:=1;
 form3.currentcol:=1;
 fileread:=false;
 env_calc:=false;
 filefiltered:=false;
 fromCSV:=false;
 numfiles:=0;
 mediaplayer1.Close;
 zip:=false; //default to WAV
 ZipMaster1.ZipFileName:='';
 //if opendialog1.execute then
 begin
     ext:=copy(opendialog1.filename,length(opendialog1.filename)-2,3);
     if uppercase(ext)='ZIP' then
     begin
       //bitbtn19.Enabled:=false;
       //bitbtn20.Enabled:=false;
       //bitbtn21.Enabled:=false;
       zip:=true;
       zipfilename:=opendialog1.filename;
       ziphome:=PathWithoutRightElement(opendialog1.filename,'\') ;
       zipname:=z_ItemCGetLast(opendialog1.filename,'\');
       ZipMaster1.ZipFileName:=opendialog1.filename;
       statusbar1.Panels[5].Text:=opendialog1.filename;
       getzipfile;
     end;
     if not zip then
     begin
       begin
        advspreadgrid1.Clear;
        advspreadGrid1.Cells[0, 0] := '0-Filename';
        advspreadGrid1.Cells[1, 0] := '1-Status';
        advspreadGrid1.Cells[2, 0] := '2-Size';
        advspreadGrid1.Cells[3, 0] := '3';
        advspreadGrid1.Cells[4, 0] := '4-Time';
        advspreadGrid1.Cells[5, 0] := '5';
        advspreadGrid1.Cells[6, 0] := '6-MsecinDay';
        bitbtn19.Enabled:=true;
        bitbtn20.Enabled:=true;
        Filepath:=PathWithoutRightElement(form1.opendialog1.filename,'\');
        path:=Filepath;
        //application.processmessages;
        if FindFirst(path+'\*.wav', faAnyFile, sr) = 0 then
        begin
         maxfilenamelength[0]:=0;
         maxfilenamelength[2]:=0;
         maxfilenamelength[5]:=0;
         advspreadGrid1.rowcount:=2;
         repeat
          begin
           advspreadGrid1.Cells[0,advspreadGrid1.RowCount-1] := copy(ExtractFileName(sr.name),1,length(sr.name)-4);
           advspreadgrid1.Cells[1, advspreadGrid1.RowCount-1]:='Delete';
           advspreadGrid1.Cells[2,advspreadGrid1.RowCount-1] := IntToStr(sr.Size);
           //application.processmessages;
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=2 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
            datestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_');
            if (timestring<>'') and (datestring <>'') then
            begin
              Hrs:=z_SMiddle(Timestring,1,2);
              Min:=z_SMiddle(Timestring,3,2);
              Sec:=z_SMiddle(Timestring,5,2);
              day:=z_SMiddle(datestring,1,2);
              month:=z_SMiddle(datestring,3,2);
              year:=z_SMiddle(datestring,5,2);
              //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=inttostr(strtoint(sec)+(60*strtoint(min))+(3600*strtoint(hrs)));
              //
              wyear:=2000+ strtoint(year);
              wmonth:=strtoint(month);
              wday:=strtoint(day);
              whrs:=strtoint(hrs);
              wmin:=strtoint(min);
              wsec:=strtoint(sec);
              secinday:=(3600*whrs)+(60*wmin)+wsec;
              msecinday:=1000*secinday;
              advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
              f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
              advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(f1Datetime);
              //datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
              //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(Datetime);
            end;
           end;
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=1 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
            if timestring<>'' then
            begin
              advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=timestring;
            end;
           end;
           advspreadGrid1.RowCount := advspreadGrid1.RowCount + 1;
          end;
         until FindNext(sr) <> 0;
        advspreadGrid1.RowCount := advspreadGrid1.RowCount-1;
        advspreadGrid1.update;
       end;
       end;
       //currentfile:=opendialog1.filename;
       advstringgrid1.Row := 1;
       currentrow:=1;
       processfile ;
     end;
  end;
  //fileread:=false;
  label55.caption:=inttostr(advspreadgrid1.RowCount)+' Files';
  readingdisk:=false;
  fitlist;
  //application.processmessages;
  //toolwindow9715.Show;
end;

procedure Tform1.fitlist;
var i:integer;
    testwidth:integer;
    maxfilenamelength:array[0..10] of integer;
    col:integer;
begin
 for i:=0 to 10 do maxfilenamelength[i]:=2;
 for col:=0 to 6 do
 begin
  advspreadGrid1.ColWidths[col]:=10;
  for i:=0 to advspreadGrid1.RowCount-1 do
  begin
           testwidth:=length(advspreadGrid1.Cells[col, i]);
           if testwidth>maxfilenamelength[col] then
           begin
            maxfilenamelength[col]:=testwidth;
            advspreadGrid1.ColWidths[col]:=testwidth*(advspreadGrid1.Font.Size-2);
           end;
   end;
  end;
end;

procedure TForm1.BitBtn16Click(Sender: TObject);
begin
   savedialog1.filter:='CSV files (*.csv)|*.CSV';
   if savedialog1.execute then advspreadgrid1.SaveToCSV(check_extension(Savedialog1.filename,'.CSV'));
end;

procedure TForm1.AdvSpreadGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var offset:integer;
    currentfile:string;
    nextfile:string;
begin

end;

procedure TForm1.About1Click(Sender: TObject);
begin
  Splash:=TSplash.create(application);
  splash.height:=576;
  //Splash.Image2.Canvas.TextOut(10,10,inttostr(form1.Regware41.daysleft));
  Splash.show;
  application.ProcessMessages;
  sleep(5000);
  splash.hide;
  splash.Destroy;
end;

procedure TForm1.rfjChart5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if checkbox37.Checked then form3.Show;
end;

procedure TForm1.Button30Click(Sender: TObject);
begin
   savedialog1.filter:='Bitmap files (*.csv)|*.CSV';
   if savedialog1.Execute then rfjchart5.dumpdata(1,Savedialog1.filename);
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
var i:integer;
begin
//firstshow:=true;
checkbox54.checked:=false; //do not use smart display
checkbox16.Checked:=checkbox36.Checked; //automatic gate channel display;
if not fileread then checkbox36.Checked:=false;
if fileread then
begin
 clickprocessing:=true;
 rfjchart2.storetracesettings;

 if checkbox36.Checked then checkbox16.enabled:=true else checkbox16.enabled:=false;
 if not checkbox36.checked then
 begin
   checkbox16.checked:=false;
   checkbox16.enabled:=false;
 end;

 wchannel:=0;rxspinedit29.Enabled:=false;
 schannel:=0;rxspinedit30.Enabled:=false;
 echannel:=0;rxspinedit31.Enabled:=false;
 gchannel:=0;rxspinedit32.Enabled:=false;

 //why is this needed?
 rfjchart2.trace[wchannel].background:=nil;
 rfjchart2.trace[echannel].background:=nil;
 rfjchart2.trace[schannel].background:=nil;
 rfjchart2.trace[gchannel].background:=nil;

 for i:=rfjchart2.traces downto 1 do
 begin
    slidepanel[i].free;
    slidepanel[i]:=nil;
    slidepanel2[i].free;
    slidepanel2[i]:=nil;
 end;
 channelcount:=0;
 if checkbox23.Checked then
 begin
   inc(channelcount);
   wchannel:=channelcount;
   rxspinedit29.Enabled:=true;
 end;
 if checkbox5.Checked then
 begin
   inc(channelcount);
   schannel:=channelcount;
   rfjchart2.trace[schannel].buffersize:=0;
   rxspinedit30.Enabled:=true;
 end;
 if checkbox36.Checked then
 begin
   inc(channelcount);
   echannel:=channelcount;
   rxspinedit31.Enabled:=true;
 end;
 if not checkbox16.Checked then
 begin
   panel22.hide;
   splitter2.Hide;
   panel21.Align:=alclient;
 end;
 if checkbox16.Checked then
 begin
   env_calc:=false;
   inc(channelcount);
   gchannel:=channelcount;
   panel21.Align:=altop;
   panel21.Height:=round(0.6*panel11.Height);
   splitter2.show;
   panel22.Show;
   rxspinedit32.Enabled:=true;
 end;
 if pagecontrol1.ActivePage=tabsheet2 then
 begin
   recalcsonogram:=true;
   chart2;
 end;
 clickprocessing:=false;
 end;
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
begin
 if checkbox11.checked then
 begin
    checkbox13.checked:=false;
    checkbox46.checked:=false;
    checkbox45.checked:=false;
    env_calc:=false;
    chart2;
 end;
end;

procedure TForm1.RxSpinEdit20Change(Sender: TObject);
begin
 if (pagecontrol1.ActivePage=tabsheet2) and checkbox12.checked then
 begin
  env_calc:=false;
  chart2;
 end;
end;

procedure TForm1.Button32Click(Sender: TObject);
begin
   editrfjchart(self, rfjchart2);
   CheckBox5Click(self);
end;


procedure TForm1.BitBtn20Click(Sender: TObject);
var i:integer;
begin
  if checkbox63.checked then
     for i:=1 to advspreadgrid1.RowCount-1 do
     begin
       advspreadgrid1.Cells[1, i]:='Print';
     end;
  if not checkbox63.checked then
     for i:=1 to advspreadgrid1.RowCount-1 do
     begin
       advspreadgrid1.Cells[1, i]:='Delete';
     end;
end;

procedure TForm1.BitBtn19Click(Sender: TObject);
var trashpath,trashpath2:string;
    fromdir,todir:string;
    i:integer;
    move_error:boolean;
    checkstate:boolean;
    arg1,arg2:string;
    cdir:string;
    result:boolean;
    count:integer;
begin
  scrollbutton.Down:=false;
  checkbox66.Checked:=false;
  application.processmessages;
  cdir:=getcurrentdir;
  pagecontrol1.activepage:= Tabsheet2; application.ProcessMessages;
  checkstate:=checkbox17.Checked;
  trashpath:=filepath+'\'+'trash\';
  trashpath2:=ziphome+'\'+'trash'+'_'+zipname+'\';
  move_error:=false;

  ptotalcount:=0;
  printcount:=advspreadgrid1.RowCount;
  for i:=1 to advspreadGrid1.rowcount-1 do
  begin
     if advspreadgrid1.Cells[1, i]='Print' then
     begin
       inc(ptotalcount);
       //if checkbox62.checked then
       begin
         sumlist[ptotalcount]:= advspreadgrid1.Cells[0,i];
         sumlistlookup[ptotalcount]:=i;
       end;
     end;
  end;

  ////////////////////////////////
  //setup preview bitmap
  //only needed for 'print'
  if checkbox64.Checked then
  begin
        printcount:=0;
        for i:=1 to advspreadgrid1.RowCount do
        begin
          if advspreadgrid1.Cells[1, i]='Print' then
          begin
            inc(printcount);
            prr:=trunc(rxspinedit41.value);
            pcc:=trunc(rxspinedit45.value);
            pcols:=trunc(rxspinedit46.value);
            pbcols:=pcols*(prr+5);
            pbrows:=ceil(printcount/pCOLS)*(pcc+5);
            if (imgview322.bitmap.width<>5+pbcols) or (imgview322.bitmap.height<>5+pbrows) then
            begin
               imgview322.Bitmap.SetSize(5+pbcols,5+pbrows);
               imgview322.Bitmap.Clear(clwhite32);
               prow:=1;pcol:=0;
            end;
          end;
        end;
  end;
  ////////////////////////////////
  if not zip then
   begin
   if not DirectoryExists(trashpath) then
    if not CreateDir(trashpath) then
     if not checkbox63.checked then raise Exception.Create('Cannot create '+trashpath);
     for i:=1 to advspreadgrid1.RowCount do
      begin
        if advspreadgrid1.Cells[1, i]='Delete' then
        begin
          label52.caption:='['+inttostr(advspreadgrid1.RowCount)+'] '+inttostr(i);
          label52.Update;
          fromdir:=filepath+'\'+advspreadgrid1.Cells[0, i]+'.wav';
          todir:=trashpath+advspreadgrid1.Cells[0, i]+'.wav';
          if not windows.movefile(pchar(fromdir),pchar(todir)) then move_error:=true;
        end;
        //do the actual printing
        if advspreadgrid1.Cells[1, i]='Print' then
         begin
           FILEREAD:=FALSE;
           currentrow:=i;
           processfile;
           application.ProcessMessages;
           if checkbox64.Checked then
              addimage(advspreadgrid1.cells[0,i])
           else
              begin
                 rfjchart2.printmag:=rxspinedit15.Value/100 ;
                 rfjchart2.print_as_bitmap;
                 application.ProcessMessages;
                 sleep(1000);
              end;
         end;
      end;
   end;
   ////////////////////////////////
   if Zip then
   begin
   if not DirectoryExists(trashpath2) then
    if not CreateDir(trashpath2) then
      if not checkbox63.checked then raise Exception.Create('Cannot create '+trashpath2);

    ZipMaster1.FSpecArgs.Clear;
    count:=0;
    for i:=1 to advspreadgrid1.RowCount do
    begin
       if advspreadgrid1.Cells[1, i]='Delete' then
       begin
          label52.caption:='['+inttostr(advspreadgrid1.RowCount)+'] '+inttostr(i);
          label52.Update;
          inc(count);
          arg1:=advspreadgrid1.Cells[5, i];
          arg2:=advspreadgrid1.Cells[0, i];
          ZipMaster1.FSpecArgs.Add(arg1+arg2);
       end;
        //do the actual printing
        if advspreadgrid1.Cells[1, i]='Print' then
         begin
           FILEREAD:=FALSE;
           currentrow:=i;
           processfile;
           application.ProcessMessages;
           if checkbox64.Checked then
              addimage(advspreadgrid1.cells[0,i])
           else
              begin
                 rfjchart2.printmag:=rxspinedit15.Value/100 ;
                 rfjchart2.print_as_bitmap;
                 application.ProcessMessages;
                 sleep(1000);
              end;
        end;
    end;
    if count>0 then
    begin
      setcurrentdir(trashpath2);
      Zipmaster1.ExtrOptions:=[];
      Zipmaster1.Extract;
      label52.caption:='Wait..(Trash)';
      label52.Update;
      for i:=1 to advspreadgrid1.RowCount do
       begin
         if advspreadgrid1.Cells[1, i]='Delete' then
         begin
            label52.caption:='['+inttostr(advspreadgrid1.RowCount)+'] '+inttostr(i);
            label52.Update;
            arg1:=advspreadgrid1.Cells[5, i];
            arg2:=advspreadgrid1.Cells[0, i];
            ZipMaster1.FSpecArgs.Add(arg1+arg2);
         end;
      end;
      label52.caption:='Wait..(Zip Delete)';
      label52.Update;
      Zipmaster1.Delete;
    end;
  end;
  ////////////////////////////////
  for i:=advspreadgrid1.RowCount downto 1 do
  begin
    if advspreadgrid1.Cells[1, i]='Delete' then
     begin
        advspreadgrid1.removerows(i,1);
        //advspreadgrid1.repaint;
     end;
  end;
  ////////////////////////////////
  label55.caption:=inttostr(advspreadgrid1.RowCount)+' Files';
  if move_error then showmessage('An ERROR occurred during moving');
  label52.caption:='DONE';
  label52.Update;
  checkbox17.Checked:=checkstate;
  setcurrentdir(cdir);
  ////////////////////////////////
end;

procedure TForm1.BitBtn21Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to advspreadgrid1.RowCount-1 do advspreadgrid1.Cells[1, i]:='';
end;

procedure TForm1.RxSpinEdit21Change(Sender: TObject);
begin
  if checkbox12.checked then
  begin
   recalcsonogram:=true;
   if checkbox47.Checked then aho_sonogram2 else sonogram2;
   rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.trace[schannel].ygmax:=trunc(rxspinedit21.Value);
   rfjchart2.trace[wchannel].ygmax:=slide2[wchannel].Position;
   rfjchart2.trace[wchannel].ygmin:=-(rfjchart2.trace[wchannel].ygmax);
   rfjchart2.backcolor:=clwhite;
   rfjchart2.keepdata:=true;
   rfjchart2.setuptraces;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.update;
   if checkbox46.checked then
   begin
          env_calc:=false;
          chart2;
   end;
  end;
end;


procedure TForm1.Options1Click(Sender: TObject);
begin
 //form9.Show;
  toolwindow978.Show;
end;


procedure TForm1.Button7Click(Sender: TObject);
begin
   if opendialog3.Execute then rxgifanimator4.Image.LoadFromFile(opendialog3.filename);
end;

procedure TForm1.RxGIFAnimator4Click(Sender: TObject);
begin
   if checkbox28.Checked then checkbox28.Checked:=false else checkbox28.Checked:=true;
end;

procedure TForm1.ToolBar1Click(Sender: TObject);
begin
   if checkbox28.Checked then checkbox28.Checked:=false else checkbox28.Checked:=true;
   printer.Orientation:=polandscape;
   printscreen;
end;

procedure printscreen;
var i:integer;
    abmp:Tbitmap;
    devicewidth,deviceheight:integer;
    screen2print:double;
    xoffset,yoffset:integer;
    xsize,ysize:integer;
begin
  for i:=0 to screen.formcount-1 do screen.Forms[i].Update;
  application.processmessages;
  abmp:=Tbitmap.create;
  ScreenShot(abmp, 0, 0, GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN), 0);
  //abmp:=form1.jvscreencapture1.CaptureScreen;
  abmp.SaveToFile('screen.bmp');
  abmp.free;

  abmp:=Tbitmap.create;
  abmp.LoadFromFile('screen.bmp');
  printer.orientation:=polandscape;
  printer.begindoc;
   with printer.canvas do
    begin
      devicewidth:=GetDeviceCaps(Handle, HORZRES);
      deviceheight:=GetDeviceCaps(Handle, VERTRES);
      screen2print:=0.8*devicewidth/abmp.width;
      xsize:=round(screen2print*abmp.width);
      ysize:=round(screen2print*abmp.height);
      xoffset:=(devicewidth-xsize) div 2;
      yoffset:=(deviceheight-ysize) div 2;
    end;
    printer.canvas.stretchdraw(rect(xoffset,yoffset,xsize+xoffset,ysize+yoffset),abmp);
  printer.enddoc;
  abmp.free;
end;

procedure TForm1.Button33Click(Sender: TObject);
var x:integer;
begin
{
  //
  rfjchart9.traces:=1;
  rfjchart9.start:=rfjchart2.start;
  rfjchart9.eind:=rfjchart2.eind;
  rfjchart9.trace[1].ygmax:=rfjchart2.trace[schannel].ygmax;
  rfjchart9.trace[1].ygmin:=rfjchart2.trace[schannel].ygmin;
  rfjchart9.showimage:=true;
  rfjchart9.setuptraces;
  rfjchart9.trace[1].imagefilter:=1+combobox8.itemindex;
  rfjchart9.trace[1].background.Assign(rfjchart2.trace[schannel].background);
  rfjchart9.drawaxes;
  rfjchart9.update;
  //application.processmessages;
  //
  imgview321.bitmap.assign(fbmp2);
  imgview321.Centered:=false;
  imgview321.Scale:=rxspinedit5.value;
  imgview321.VScroll.Range:=2*imgview321.VScroll.range;
  //imgview321.VScroll.Show;
  imgview321.Centered:=TRUE;
  imgview321.Scale:=RXSPINEDIT1.VALUE;
  {
  with L1.Bitmap do
  begin
    BeginUpdate;
    L1.BitmapCenter := FloatPoint(Width / 2, Height / 2);
    L1.Bitmap.assign(fbmp2);
    SetBorderTransparent(L1.Bitmap, Rect(0, 0, Width - 1, Height - 1));
    L1.Bitmap.MasterAlpha:=128;
    DrawMode := dmblend;
    StretchFilter := sfLinear;
    EndUpdate;
    Changed;
  end;
  L1.Scaled := True;
  L1.Position := FloatPoint(100, 100);
  }

end;


procedure TForm1.Button34Click(Sender: TObject);
begin
  rfjchart8.traces:=1;
  rfjchart8.start:=rfjchart2.start;
  rfjchart8.eind:=rfjchart2.eind;
  rfjchart8.trace[1].ygmax:=rfjchart2.trace[schannel].ygmax;
  rfjchart8.trace[1].ygmin:=rfjchart2.trace[schannel].ygmin;
  rfjchart8.showimage:=true;
  rfjchart8.setuptraces;
  rfjchart8.trace[1].imagefilter:=1+combobox8.itemindex;
  rfjchart8.trace[1].background.Assign(rfjchart2.trace[schannel].background);
  rfjchart8.drawaxes;
  rfjchart8.update;
  with L2.Bitmap do
  begin
    BeginUpdate;
     L2.Bitmap.assign(fbmp2);
     L2.BitmapCenter := FloatPoint(Width / 2, Height / 2);
     SetBorderTransparent(L2.Bitmap, Rect(0, 0, Width - 1, Height - 1));
     L2.Bitmap.MasterAlpha:=TRUNC(RXSPINEDIT23.VALUE);
     DrawMode := dmblend;  //dmopaque
     StretchFilter := sfLinear;
    EndUpdate;
    Changed;
  end;
  L2.Scaled := True;
  L2.Position := FloatPoint(0,0);
end;


procedure TForm1.ImgView321MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
{
 dobitmapmove:=true;
 bmm_x:=x;
 bmm_y:=y;
}
end;

procedure TForm1.ImgView321MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer; Layer: TCustomLayer);
var
  P: TFloatPoint;
  p2:Tfloatpoint;
  xtest_r,ytest_l:integer;
  xtest_l,ytest_u:integer;
begin
{
 xtest_R:=round((x+(l2.Bitmap.Width/2)*imgview321.scale));
 ytest_l:=round((y+(l2.Bitmap.height/2)*imgview321.scale));
 xtest_l:=round((x-(l2.Bitmap.Width/2)*imgview321.scale));
 ytest_u:=round((y-(l2.Bitmap.height/2)*imgview321.scale));
 while dobitmapmove do
 begin
  p:= L2.position;
  P.X := (l2.Bitmap.Width/2)-(x+imgview321.HScroll.Position)/imgview321.Scale;
  P.Y := (l2.Bitmap.height/(2*imgview321.Scale))-(y+imgview321.VScroll.position)/imgview321.Scale;
  //L2.Bitmapcenter := P;
  if xtest_r>imgview321.Width then
  begin
   imgview321.Scroll(imgview321.Bitmap.Width div 250,0);
  end;
  if xtest_l<0 then
  begin
   imgview321.Scroll(-imgview321.Bitmap.Width div 250,0);
  end;
  if ytest_l>imgview321.height then
  begin
   imgview321.Scroll(0,imgview321.Bitmap.Width div 250);
  end;
  if ytest_u<0 then
  begin
   imgview321.Scroll(0,-imgview321.Bitmap.Width div 250);
  end;
  application.processmessages;
  imgview321.Update;
 end;
}
end;


procedure TForm1.ImgView321MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
{
 dobitmapmove:=false;
 imgview321.Update;
 application.processmessages;
}
end;

procedure TForm1.RxSpinEdit23Change(Sender: TObject);
begin
 L2.Bitmap.MasterAlpha:=TRUNC(RXSPINEDIT23.VALUE);
end;

procedure TForm1.RxSpinEdit22Change(Sender: TObject);
begin
    if checkbox16.Checked then
        if checkbox12.checked then
           echannel_leftscroll_change(self);
end;

procedure TForm1.RxSpinEdit24Change(Sender: TObject);
begin
   if checkbox16.Checked then
     if checkbox12.checked then  echannel_leftscroll_change(self);
end;

procedure TForm1.CheckBox38Click(Sender: TObject);
begin
  if checkbox38.Checked and fileread then button14click(self);
end;

procedure TForm1.CheckBox37Click(Sender: TObject);
begin
 if checkbox37.checked then form3.Show else form3.Hide;
end;

procedure TForm1.RxSpinEdit26Change(Sender: TObject);
begin
 form1.makegatehis;
end;

procedure TForm1.RxSpinEdit25Change(Sender: TObject);
begin
 form1.makegatehis;
end;

procedure TForm1.Button31Click(Sender: TObject);
begin
 //rfjchart1.bmp.SaveToClipboard;
end;

procedure TForm1.Button35Click(Sender: TObject);
begin
  if printersetupdialog1.Execute then rfjchart3.print_as_bitmap;
end;

procedure TForm1.Button36Click(Sender: TObject);
begin
 if checkbox52.checked then
 begin
   info2spreadsheet ;
 end;
 advstringgrid1.CopyToClipBoard;
end;

procedure TForm1.BitBtn22Click(Sender: TObject);
begin
if printersetupdialog1.Execute then advstringgrid2.Print;
end;

procedure TForm1.BitBtn23Click(Sender: TObject);
var shiftsize:double;
begin
   shiftsize:=0.2*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit13.value:=rxspinedit13.value-shiftsize;
   rxspinedit12.value:=rxspinedit12.value+shiftsize;
   button14click(self);
   //recalcsonogram:=true;
   //env_calc:=false;
   //if fileread then processfile;
end;

procedure TForm1.ToolButton12Click(Sender: TObject);
begin
 if fontdialog1.Execute then advstringgrid2.Font:=fontdialog1.Font;
end;

procedure TForm1.useharddiskClick(Sender: TObject);
begin
   if usedisk=true then usedisk:=false else usedisk:=true;
end;

procedure TForm1.usememoryClick(Sender: TObject);
begin
 useharddisk.Checked:=false;
end;

procedure TForm1.RxSpinEdit28Change(Sender: TObject);
begin
  makedurationhis;
end;

procedure TForm1.RxSpinEdit27Change(Sender: TObject);
begin
   makedurationhis;
end;

procedure TForm1.Button37Click(Sender: TObject);
begin
 rfjchart6.bmp.SaveToClipboard;
end;

procedure TForm1.Button38Click(Sender: TObject);
begin
  if printersetupdialog1.Execute then rfjchart6.print_as_bitmap;
end;

procedure TForm1.Button39Click(Sender: TObject);
begin
 //button14Click(self);
 toolwindow9715.Hide;
end;

procedure TForm1.PageControl2Change(Sender: TObject);
begin
    if pagecontrol2.ActivePage=pagecontrol2.Pages[0] then makegatehis;
    if pagecontrol2.ActivePage=pagecontrol2.Pages[1] then makedurationhis;
end;

procedure TForm1.Button40Click(Sender: TObject);
begin
 button36click(self);
 if checkbox48.Checked then
    if printersetupdialog1.Execute then advstringgrid1.Print
 else advstringgrid1.Print;
end;

procedure TForm1.CheckBox29Click(Sender: TObject);
begin
  //bsheet4.Visible:=checkbox29.checked;
  pagecontrol1.Pages[3].tabVisible:=checkbox29.Checked;
end;

procedure TForm1.RxSpinEdit29Change(Sender: TObject);
begin
 if not lockupdate then
 begin
   rfjchart2.trace[wchannel].traceheight:=trunc(rxspinedit29.value);
   rfjchart2.trace[wchannel].traceheightfixed:=true;
   checkbox40.Checked:=true;
   rfjchart2.setuptraces;
   rfjchart2.savetraces;
   slidepanel[1]:=nil;
   slidepanel2[1]:=nil;
   slidepanel[2]:=nil;
   slidepanel2[2]:=nil;
   slidepanel[3]:=nil;
   slidepanel2[3]:=nil;
   slidepanel[4]:=nil;
   slidepanel2[4]:=nil;
   chart2;
 end;
end;

procedure TForm1.RxSpinEdit30Change(Sender: TObject);
begin
 if not lockupdate then
 begin
   rfjchart2.trace[schannel].traceheight:=trunc(rxspinedit30.value);
   rfjchart2.trace[schannel].traceheightfixed:=true;
   checkbox41.Checked:=true;
   rfjchart2.setuptraces;
   rfjchart2.savetraces;
    slidepanel[1]:=nil;
   slidepanel2[1]:=nil;
   slidepanel[2]:=nil;
   slidepanel2[2]:=nil;
   slidepanel[3]:=nil;
   slidepanel2[3]:=nil;
   slidepanel[4]:=nil;
   slidepanel2[4]:=nil;
   chart2;
 end;
end;

procedure TForm1.RxSpinEdit31Change(Sender: TObject);
begin
 if not lockupdate then
 begin
   rfjchart2.trace[echannel].traceheight:=trunc(rxspinedit31.value);
   rfjchart2.trace[echannel].traceheightfixed:=true;
   checkbox42.Checked:=true;
   rfjchart2.setuptraces;
   rfjchart2.savetraces;
    slidepanel[1]:=nil;
   slidepanel2[1]:=nil;
   slidepanel[2]:=nil;
   slidepanel2[2]:=nil;
   slidepanel[3]:=nil;
   slidepanel2[3]:=nil;
   slidepanel[4]:=nil;
   slidepanel2[4]:=nil;

   chart2;
 end;
end;

procedure TForm1.RxSpinEdit32Change(Sender: TObject);
begin
 if not lockupdate then
 begin
   rfjchart2.trace[gchannel].traceheight:=trunc(rxspinedit32.value);
   rfjchart2.trace[gchannel].traceheightfixed:=true;
   checkbox43.Checked:=true;
   rfjchart2.setuptraces;
   rfjchart2.savetraces;
   slidepanel[1]:=nil;
   slidepanel2[1]:=nil;
   slidepanel[2]:=nil;
   slidepanel2[2]:=nil;
   slidepanel[3]:=nil;
   slidepanel2[3]:=nil;
   slidepanel[4]:=nil;
   slidepanel2[4]:=nil;
   chart2;
 end;
end;

procedure TForm1.CheckBox40Click(Sender: TObject);
begin
   rfjchart2.trace[wchannel].traceheightfixed:=checkbox40.Checked;
     rfjchart2.setuptraces;
     rfjchart2.savetraces;
   if wchannel<>0 then begin
     slidepanel[1]:=nil;
     slidepanel2[1]:=nil;
     slidepanel[2]:=nil;
     slidepanel2[2]:=nil;
     slidepanel[3]:=nil;
     slidepanel2[3]:=nil;
     slidepanel[4]:=nil;
     slidepanel2[4]:=nil;
     chart2;
   end;
end;

procedure TForm1.CheckBox41Click(Sender: TObject);
begin
   rfjchart2.trace[schannel].traceheightfixed:=checkbox41.Checked;
     rfjchart2.setuptraces;
     rfjchart2.savetraces;
   if schannel<>0 then begin
     slidepanel[1]:=nil;
     slidepanel2[1]:=nil;
     slidepanel[2]:=nil;
     slidepanel2[2]:=nil;
     slidepanel[3]:=nil;
     slidepanel2[3]:=nil;
     slidepanel[4]:=nil;
     slidepanel2[4]:=nil;
     chart2;
   end;
end;

procedure TForm1.CheckBox42Click(Sender: TObject);
begin
   rfjchart2.trace[echannel].traceheightfixed:=checkbox42.Checked;
     rfjchart2.setuptraces;
     rfjchart2.savetraces;
   if echannel<>0 then begin
     slidepanel[1]:=nil;
     slidepanel2[1]:=nil;
     slidepanel[2]:=nil;
     slidepanel2[2]:=nil;
     slidepanel[3]:=nil;
     slidepanel2[3]:=nil;
     slidepanel[4]:=nil;
     slidepanel2[4]:=nil;
     chart2;
   end;
end;

procedure TForm1.CheckBox43Click(Sender: TObject);
begin
   rfjchart2.trace[gchannel].traceheightfixed:=checkbox43.Checked;
    rfjchart2.setuptraces;
     rfjchart2.savetraces;

   if gchannel<>0 then begin
     slidepanel[1]:=nil;
     slidepanel2[1]:=nil;
     slidepanel[2]:=nil;
     slidepanel2[2]:=nil;
     slidepanel[3]:=nil;
     slidepanel2[3]:=nil;
     slidepanel[4]:=nil;
     slidepanel2[4]:=nil;
     chart2;
   end;
end;

procedure TForm1.AdvSpreadGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    //if fileread then processfile else beep;;
end;

procedure TForm1.AdvSpreadGrid1CellChanging(Sender: TObject; OldRow,
  OldCol, NewRow, NewCol: Integer; var Allow: Boolean);
begin
 if fileread then processfile else beep
end;

procedure TForm1.AdvSpreadGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 currentrow:=advspreadgrid1.ROW;
 fileread:=false;
 env_calc:=false;
 recalcsonogram:=true;
 processfile;
end;

procedure TForm1.CheckBox45Click(Sender: TObject);
var checkstate:boolean;
    realfilename:string;
begin
 if fileread then
 begin
   if checkbox45.Checked then checkbox46.checked:=true;
   checkstate:=checkbox26.Checked;
   checkbox26.Checked:=true;
   fileread:=false;
   env_calc:=false;
   recalcsonogram:=true;
   realfilename:=currentfile;
   currentfile:=opendialog1.FileName;
   if not fileread then showwave;
   if checkbox45.checked then filter2;
   currentfile:=realfilename;
   begin
           chart;
           if (pagecontrol1.ActivePage=tabsheet2) and checkbox9.checked then count2;
           application.ProcessMessages;
           if checkbox7.Checked then if checkbox47.Checked then aho_sonogram2 else sonogram2;
    end;
   checkbox26.Checked:=checkstate;
 end;
end;

procedure TForm1.RxSpinEdit33Change(Sender: TObject);
var checkstate:boolean;
    realfilename:string;
begin
 if fileread then
 begin
   showbmphis;
   {
   checkstate:=checkbox26.Checked;
   checkbox26.Checked:=true;
   fileread:=false;
   env_calc:=false;
   recalcsonogram:=true;
   realfilename:=currentfile;
   currentfile:=opendialog1.FileName;
   if not fileread then showwave;
   if checkbox45.checked then filter2;
   currentfile:=realfilename;
   chart2;
   if checkbox9.checked then count2;
   checkbox26.Checked:=checkstate;
   }
 end;
end;

procedure TForm1.CheckBox46Click(Sender: TObject);
begin
 if checkbox46.checked then
 begin
      //checkbox45.Checked:=true;
      checkbox11.checked:=false;
      checkbox13.checked:=false;
      env_calc:=false;
      chart2;
 end;
end;

procedure TForm1.RxSpinEdit34Change(Sender: TObject);
begin
 if fileread and  checkbox12.checked then
 begin
   env_calc:=false;
   chart2;
 end;
end;

procedure TForm1.Button42Click(Sender: TObject);
begin
       if savedialog5.Execute then fbmp2.SaveToFile(savedialog5.filename);
end;

procedure TForm1.Button43Click(Sender: TObject);
var abmp:Tpicture;
begin
 abmp:=Tpicture.create;
 abmp.bitmap.Width:=100;
 abmp.bitmap.Height:=100;
 abmp.bitmap.PixelFormat:=pf32bit;
 abmp.bitmap.LoadFromFile('c:\incoming\rfj.bmp');
 advspreadgrid3.CreatePicture(1,1,false,stretch,0,haleft,vatop);
 advspreadgrid3.AddPicture(1,1,abmp,false,stretch,0,haleft,vatop);
 advspreadgrid3.Cells[2,2]:='1.001';
 AdvPreviewDialog1.Grid := AdvspreadGrid3;
 AdvPreviewDialog1.Execute;
 advspreadgrid3.Savetoxls('c:\incoming\test.xls');
end;


procedure TForm1.CheckBox47Click(Sender: TObject);
begin
  {
   if checkbox47.checked then
    begin
      groupbox12.enabled:=true;
      groupbox7.enabled:=false;
    end
   else
    begin
      groupbox12.enabled:=false;
      groupbox7.enabled:=true;
    end;
   }
   if checkbox12.Checked then
   begin
     recalcsonogram:=true;
     if checkbox46.Checked then env_calc:=false;
     chart2;
   end;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
begin
 if checkbox47.Checked and checkbox12.checked then
 begin
  recalcsonogram:=true;
  if checkbox46.Checked then  env_calc:=false;
  chart2;
 end;
end;

procedure TForm1.RxSpinEdit37Change(Sender: TObject);
begin
 if checkbox47.Checked and checkbox12.checked then
 begin
  recalcsonogram:=true;
  if checkbox46.Checked then env_calc:=false;
  chart2;
 end;
end;

procedure TForm1.Button44Click(Sender: TObject);
var i:integer ;
    gatefile:textfile;
    gatefilename:string;
    rownumber:integer;
    cellvalue:string;
begin
 if not checkbox53.Checked then showmessage(' This only works if you set the FILE TIME option on the EXTRA page (re-do the file)');
 gatefilename:=currentfile+'.gate.csv';
 savedialog6.filename:=gatefilename;
 if checkbox48.Checked then
   if savedialog6.execute then gatefilename:=savedialog6.filename
 else gatefilename:=currentfile+'.gate.csv';
 advstringgrid1.savetocsv(gatefilename);
end;

procedure TForm1.Button45Click(Sender: TObject);
begin
  fbmp2.SaveToClipboard;
end;

procedure TForm1.CheckBox12Click(Sender: TObject);
begin
 if (checkbox12.checked and checkbox47.Checked) then
    aho_sonogram2
 else if checkbox12.checked then sonogram2;
end;

procedure TForm1.Button46Click(Sender: TObject);
var i:integer ;
    gatefile:textfile;
    gatefilename:string;
    rowfilled:boolean;
    rownumber:integer;
    cell:string;
    rows:integer;
begin
 if not checkbox53.Checked then showmessage(' This only works if you set the FILE TIME option on the EXTRA page (re-do the file)');
 gatefilename:=currentfile+'.gate.csv';
 savedialog6.filename:=gatefilename;
 if checkbox48.Checked then
   if savedialog6.execute then gatefilename:=savedialog6.filename
 else gatefilename:=currentfile+'.gate.csv';
 advstringgrid1.Clear;
 advstringgrid1.LoadFromCSV(gatefilename);
 rows:=advstringgrid1.RowCount;
 rfjchart2.trace[gchannel].pen.Color:=clwhite;
 rfjchart2.trace[gchannel].linecolor:=clwhite32;
 rfjchart2.reset;
 rfjchart2.drawmode:=dmline;
 rfjchart2.trace[gchannel].pen.Color:=clblue;
 rfjchart2.trace[gchannel].linecolor:=clblue32;
 rownumber:=0;
 rowfilled:=(advstringgrid1.cells[0,rownumber]<>'') or (advstringgrid1.cells[1,rownumber]<>'');
 for rownumber:=0 to rows do
 begin
     cell:=advstringgrid1.cells[0,rownumber];
     if cell<>'' then rfjchart2.addpoint(gchannel,strtofloat(cell),0);
     if cell<>'' then rfjchart2.addpoint(gchannel,strtofloat(cell),90);
     cell:=advstringgrid1.cells[1,rownumber];
     if cell<>'' then rfjchart2.addpoint(gchannel,strtofloat(cell),90);
     if cell<>'' then rfjchart2.addpoint(gchannel,strtofloat(cell),0);
     rfjchart2.update;
     advstringgrid1.SelectRows(rownumber-1,1);
     //application.processmessages;
     //sleep(100);
 end;
 rfjchart2.update;
 rfjchart2.trace[gchannel].pen.Color:=clblack;
 rfjchart2.trace[gchannel].linecolor:=clblack32;
end;


procedure TForm1.CheckBox26Click(Sender: TObject);
begin
 adjusttime:=not checkbox26.Checked;
end;

procedure TForm1.rfjChart7click(Sender: TObject);
begin
 showbmphis;
end;

procedure TForm1.rfjChart7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
    form3.Label2.caption:=floattostrf(rfjchart7.xpos2val(x,y),fffixed,6,2);
    form3.Label4.caption:=floattostr(rfjchart7.ypos2val(x,y));
end;

procedure TForm1.Button47Click(Sender: TObject);
begin
   rfjchart4.bmp.SaveToClipboard;
end;

procedure TForm1.Button48Click(Sender: TObject);
begin
    if printersetupdialog1.Execute then
    begin
     printer.orientation:=polandscape;
     printer.begindoc;
      rfjchart4.drawmode:=dmskyline;
      rfjchart4.printmag:=0.5;
      rfjchart4.printeryoffset:=0;
      rfjchart4.printerxoffset:=0;
      rfjchart4.getprinterpar;
      rfjchart4.printerdrawaxes;
      rfjchart4.printer_trace[1].clipy:=true;
      rfjchart4.printerdrawbuffer;
     printer.enddoc;
    end;
end;

procedure TForm1.BitBtn24Click(Sender: TObject);
var windowsize:double;
    shiftsize:double;
begin
   shiftsize:=0.2*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit13.value:=rxspinedit13.value+shiftsize;
   rxspinedit12.value:=rxspinedit12.value-shiftsize;
   button14click(self);
   //recalcsonogram:=true;
   //env_calc:=false;
   //if fileread then processfile;
end;

procedure TForm1.BitBtn25Click(Sender: TObject);
begin
  advspreadgrid1.CopyToClipBoard;
end;

procedure TForm1.BitBtn26Click(Sender: TObject);
var windowsize:double;
    shiftsize:double;
begin
   windowsize:=(rxspinedit13.value-rxspinedit12.value);
   shiftsize:=(rxspinedit10.value/100)*(rxspinedit13.value-rxspinedit12.value);
   rxspinedit12.value:=rxspinedit12.value-shiftsize;
   rxspinedit13.value:=rxspinedit12.value+windowsize;
   recalcsonogram:=true;
   if fileread then processfile;
end;


procedure TForm1.Button49Click(Sender: TObject);
begin
  rfjchart2.bmp.savetoclipboard;
end;

procedure TForm1.CheckBox49Click(Sender: TObject);
begin
    if checkbox12.checked then
    begin
      env_calc:=false;
      chart2;
   end;
end;

procedure TForm1.Button50Click(Sender: TObject);
var binsize:integer;
    bindata:array of integer;
    nofbins:integer;
    i:integer;
    time:extended;
    bin:integer;
    ymax:integer;
    nofunderscores:integer;
    secinfile:integer;
    t:integer;
    filesize:integer;
    testtime,tmax,tmin:Tdatetime;
    datetimezero,currentdatetime:Tdatetime;
    start,eind,temp,onesec:extended;
    range:integer;
    reccount:integer;
begin
    nofunderscores:=(z_ItemCCount(advspreadGrid1.Cells[0, 1],'_')-1);
    form11.Show;
    ymax:=-1;

    //find min and max times in file
    Tmax:=0;
    Tmin:=maxint;
    for i:=1 to form1.advspreadgrid1.rowcount do
    begin
      if (form1.advspreadgrid1.cells[4,i]<>'') and (form1.advspreadgrid1.cells[1,i]<>'Delete')  then
      begin
          testtime:=strtofloat(form1.advspreadgrid1.cells[4,i]);
          if testtime<Tmin then Tmin:=testtime;
          if testtime>Tmax then Tmax:=testtime;
      end;
    end;
    DateTimeZero:=Tmin;
    temp:=Tmax;
    eind:=ceil(temp);
    temp:=Tmin;
    start:=floor(temp);
    datetime_start:=start;
    temp:=(eind-start);
    Range:=ceil(Temp);
    temp:=encodetime(0,0,1,0);
    onesec:=temp;
    binsize:=(trunc(form11.rxspinedit1.value));
    nofbins:=1+round(range/(binsize*onesec));
    setlength(bindata,nofbins+1);
    advspreadgrid1.row:=1;

    if nofunderscores=1 then
    begin
       nofbins:=1+((6*3600) div binsize);
       setlength(bindata,nofbins+1);
    end;

    reccount:=0;
    for i:=0 to nofbins do bindata[i-1]:=0;
    for i:=1 to form1.advspreadgrid1.rowcount do
    begin
      if (form1.advspreadgrid1.cells[4,i]<>'') and (form1.advspreadgrid1.cells[1,i]<>'Delete') then
      begin
        filesize:=strtoint(form1.advspreadgrid1.cells[2,i])-44;
        secinfile:=filesize div (rate*2);
        //time:=strtoint(form1.advspreadgrid1.cells[4,i]);
        currentdatetime:=strtofloat(form1.advspreadgrid1.cells[4,i]);
        time:=currentdatetime-start;
        if secinfile>=form11.rxspinedit2.value then
        begin
          inc(reccount);
          if form11.CheckBox1.Checked then
            for t:=0 to secinfile-1 do
            begin
              time:=time+(t*onesec);
              bin:=1+trunc(time/(binsize*onesec));
              inc(bindata[bin]);
              if bindata[bin]>ymax then ymax:=bindata[bin]+2;
            end
          else
            begin
             bin:=1+trunc(time/(binsize*onesec));
             inc(bindata[bin]);
             if bindata[bin]>ymax then ymax:=bindata[bin]+2;
            end;
        end;
      end;
    end;
    if nofunderscores=2 then
             form11.rfjChart1.trace[1].xaxislegend:='Days (One Day = 1.00 units)';
    if nofunderscores=1 then
             form11.rfjChart1.trace[1].xaxislegend:='Time Relative to Start Recording(Sec)';
    with form11 do
    begin
        rfjchart1.buffered:=true;
        rfjchart1.traces:=2;
        rfjchart1.traces:=1;
        rfjchart1.trace[1].ygmin:=0;
        rfjchart1.trace[1].ygmax:=ymax;
        rfjchart1.backcolor:=clwhite;
        rfjchart1.trace[1].pen.color:=clblack;
        rfjchart1.trace[1].xmargintop:=35;
        rfjchart1.trace[1].xmarginbottom:=60;
        rfjchart1.trace[1].xaxispen.color:=clblack;
        rfjchart1.trace[1].yaxispen.color:=clblack;
        rfjchart1.trace[1].clipy:=true;
        rfjchart1.start:=0;
        rfjchart1.eind:=range;//(nofbins*binsize)/3600;
        if nofunderscores=1 then rfjchart1.eind:=21600;
        rfjchart1.trace[1].ymarginleft:=30;
        rfjchart1.trace[1].ymarginright:=10;
        rfjchart1.trace[1].yaxislegend:='';
        rfjchart1.trace[1].showtitle:=true;
        rfjchart1.trace[1].graphtitle:=opendialog1.filename+', '+inttostr(binsize)+', '+inttostr(reccount)+' recordings';
        rfjchart1.trace[1].graphtitleyoffset:=-20;
        rfjchart1.setuptraces;
        rfjchart1.drawaxes;
        rfjchart1.reset;
        //rfjchart1.setmemsize(1,nofbins);
        rfjchart1.drawmode:=dmbar;
        for i:=1 to nofbins do
        begin
            if nofunderscores=1 then
               rfjchart1.addpoint(1,(i*binsize),bindata[i])
            else
               rfjchart1.addpoint(1,(i*binsize*onesec),bindata[i]);
        end;
        rfjchart1.update;
    end;
end;

procedure TForm1.Button51Click(Sender: TObject);
begin
 advstringgrid2.PasteselectionFromClipboard;
end;

procedure TForm1.CheckBox21Click(Sender: TObject);
begin
 if checkbox21.Checked then  showbmphis;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
 form8.Hide;
 if (not checkbox51.Checked) and checkbox6.Checked then form8.Show;
end;

procedure Tform1.drawgatemarks;
var memsize:integer;
    testhi,testlo:extended;
    gridrow:integer;
    i:integer;
    prevgatelevel,gatelevel:integer;
    prevgateswitch,gateswitch:integer;
    gateinterval,gatetime:double;
    testgate:integer;
    testgatelevel:integer;
    fastnoise:boolean;
    j:integer;
    t1,t2,freq:int64;
    elapsed:integer;
    sono2time:double;
    testlevel:integer;
    darkcount,testcountlevel:integer;
    gatecol:integer;
    clip32:Tbitmap32;
    clip:Tpicture;
    wenthigh:integer;
    hasbeenhigh:boolean;
    hitime,lotime:integer;
    realstart:integer;
    currenttime:double;
    realgatelevel:integer;
begin
   if checkbox16.Checked then
   begin
    rfjchart2.drawmode:=dmline;
    testhi:=(slide[echannel].max-slide[echannel].Position);
    testlo:=(slide[echannel].max-slide[echannel].Position-rxspinedit22.value);
    testgate:=trunc(rate*rxspinedit24.value/1000);
    if (ebuffer[1]>testhi) then prevgatelevel:=90 ;
    if (ebuffer[1]<testlo) then prevgatelevel:=0;
    hitime:=trunc(rate*rxspinedit24.value/1000);
    lotime:=trunc(rate*rxspinedit6.value/1000);

    //ravg-envelope en fir-envelope en sonogram envelope
    if checkbox11.Checked or checkbox13.Checked or checkbox46.Checked then
    begin
      while i<eindsample-1 do
      begin
          if realstart>i then
          begin
             i:=realstart;
             //prevgatelevel:=realgatelevel;
          end;
          if (i<high(ebuffer[i])) and (ebuffer[i]>testhi) then gatelevel:=90 ;
          if (i<high(ebuffer[i])) and (ebuffer[i]<testlo) then gatelevel:=0;
          if prevgatelevel=gatelevel then rfjchart2.addpoint(gchannel,1000*i/rate,gatelevel);
          if prevgatelevel<>gatelevel then
          begin
             //transition?
             fastnoise:=false;
             if gatelevel=90 then testgate:=hitime;
             if gatelevel=0 then testgate:=lotime;
             for j:=i to (i+testgate) do
             begin
                  if (ebuffer[j]>testhi) then testgatelevel:=90 ;
                  if (ebuffer[j]<testlo) then testgatelevel:=0;
                  if testgatelevel<>gatelevel then
                  begin
                     fastnoise:=true;
                     realstart:=j;
                     //realgatelevel:=testgatelevel;
                     break;
                  end;
             end;
             if fastnoise then gatelevel:=prevgatelevel;
             if not fastnoise then
             begin
               prevgateswitch:=gateswitch;
               gateswitch:=i;
               gateinterval:=1000*((gateswitch-prevgateswitch)/rate);
               gatetime:=1000*i/rate;
               if gatelevel=90 then
               begin
                   if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
               end;
               if gatelevel=0 then
               begin
                    if checkbox49.Checked then rfjchart2.setxmark(schannel,gatetime);
               end;
               prevgatelevel:=gatelevel;
             end;
          end;
         inc(i);
        end;
      end;
   rfjchart2.update;
  end;
end;


procedure TForm1.AdvStringGrid2ClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  advstringgrid2.Row:=arow;
  advstringgrid2.Col:=acol;
end;

procedure TForm1.Button53Click(Sender: TObject);
begin
  // htmlLite1.LoadFromFile(programhome+'\help\main_map.htm');
end;

procedure TForm1.Button52Click(Sender: TObject);
begin
//htmllite1.
end;

procedure TForm1.RxSpinEdit21BottomClick(Sender: TObject);
begin
  if checkbox12.checked then
  begin
   recalcsonogram:=true;
   if checkbox47.Checked then aho_sonogram2 else sonogram2;
   rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.trace[schannel].ygmax:=trunc(rxspinedit21.Value);
   rfjchart2.trace[wchannel].ygmax:=slide2[wchannel].Position;
   rfjchart2.trace[wchannel].ygmin:=-(rfjchart2.trace[wchannel].ygmax);
   rfjchart2.backcolor:=clwhite;
   rfjchart2.keepdata:=true;
   rfjchart2.setuptraces;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.update;
   if checkbox46.checked then
   begin
          env_calc:=false;
          chart2;
   end;
  end;
end;

procedure TForm1.RxSpinEdit21TopClick(Sender: TObject);
begin
  if checkbox12.checked then
  begin
   recalcsonogram:=true;
   if checkbox47.Checked then aho_sonogram2 else sonogram2;
   rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.trace[schannel].ygmax:=trunc(rxspinedit21.Value);
   rfjchart2.trace[wchannel].ygmax:=slide2[wchannel].Position;
   rfjchart2.trace[wchannel].ygmin:=-(rfjchart2.trace[wchannel].ygmax);
   rfjchart2.backcolor:=clwhite;
   rfjchart2.keepdata:=true;
   rfjchart2.setuptraces;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.update;
   if checkbox46.checked then
   begin
          env_calc:=false;
          chart2;
   end;
  end;
end;

procedure TForm1.Button54Click(Sender: TObject);
begin
  save_result:=true;
  Button86Click(Self);
  save_result:=false;
end;

procedure TForm1.JvSpinEdit1Change(Sender: TObject);
begin
  if checkbox12.checked then
  begin
   //rxspinedit21.value:=jvspinedit1.Value;
   recalcsonogram:=true;
   if checkbox47.Checked then aho_sonogram2 else sonogram2;
   rfjchart2.trace[schannel].imagefilter:=1+combobox8.itemindex;
   rfjchart2.trace[schannel].background:=fbmp2;
   rfjchart2.trace[schannel].ygmax:=trunc(rxspinedit21.Value);
   rfjchart2.trace[wchannel].ygmax:=slide2[wchannel].Position;
   rfjchart2.trace[wchannel].ygmin:=-(rfjchart2.trace[wchannel].ygmax);
   rfjchart2.backcolor:=clwhite;
   rfjchart2.keepdata:=true;
   rfjchart2.setuptraces;
   rfjchart2.drawaxes;
   rfjchart2.reset;
   rfjchart2.drawbuffer;
   rfjchart2.update;
   if checkbox46.checked then
   begin
          env_calc:=false;
          chart2;
   end;
  end;
end;

procedure TForm1.JvSpinEdit6Change(Sender: TObject);
begin
      label119.Enabled:=true;
end;

procedure TForm1.Button55Click(Sender: TObject);
var savesort:file of byte;
    i:integer;
    maxcluster:integer;
begin
   //load result
   if opendialog4.Execute then
   begin
    assignfile(savesort,opendialog4.FileName);
    reset(savesort);
    maxcluster:=0;
    if not floatdat then
     for i:=1 to lcount do
     begin
       blockread(savesort,kmeans1.iwork[i-1],1);
       if kmeans1.iwork[i-1]>maxcluster then maxcluster:=kmeans1.iwork[i-1];
     end;
     if floatdat then
     for i:=1 to lcount do
     begin
       blockread(savesort,kmeans1F.iwork[i-1],1);
       if kmeans1F.iwork[i-1]>maxcluster then maxcluster:=kmeans1F.iwork[i-1];
     end;

    numclusters:=maxcluster;
    closefile(savesort);
    button86click(self);
   end;
end;

procedure TForm1.Button57Click(Sender: TObject);
begin
     checkbox73.Checked:=false;
     application.processmessages;
     scrollbutton.Down:=true;
     rxspinedit12.value:=0;
     rxspinedit13.value:=slen3;
     checkbox66.Checked:=scrollbutton.Down;
     application.ProcessMessages;
     if fileexists('$$$.wav') then deletefile('$$$.wav');
     opendialog1.FileName:='';

     OpenWavZip1Click(self);
     sleep(1000);
     checkbox2.Checked:=true;
     sleep(1000);
     savebitmaps:=true;
     button4click(self);
     savebitmaps:=false;
     if fileexists('$$$.wav') then deletefile('$$$.wav');
     pagecontrol1.activepage:=External_Data;
end;

procedure TForm1.Button56Click(Sender: TObject);
begin
      //processing:=true;
      //mynewfilename := 'c:\temp\soundimages.db';
      //FFile := TFileStream.Create(mynewfilename,fmCreate);
      //splash.show;
      //application.ProcessMessages;
      form1.Show;
      //application.ProcessMessages;
      //form2.show;
      application.ProcessMessages;
      form3.Show;
      //application.ProcessMessages;
      //form4.show;
      application.ProcessMessages;
      form5.Show;
      application.ProcessMessages;
      form6.show;
      application.ProcessMessages;
      form7.Show;
      application.ProcessMessages;
      form8.show;
      application.ProcessMessages;
      form9.Show;
      application.ProcessMessages;
      form10.show;
      application.ProcessMessages;
      form11.Show;
      application.ProcessMessages;
      printpreview.show;
      //application.ProcessMessages;
      //form13.Show;
      application.ProcessMessages;
      form14.show;
      //application.ProcessMessages;
      //form15.Show;
      //application.ProcessMessages;
      //form16.show;
      //application.ProcessMessages;
      //form17.Show;
      application.ProcessMessages;
      form18.show;
      //application.ProcessMessages;
      //form19.Show;
      application.ProcessMessages;
      form20.show;
      application.ProcessMessages;
      form21.Show;
      application.ProcessMessages;
      form22.show;
      application.ProcessMessages;
      form23.show;
      application.ProcessMessages;
      form24.Show;
      application.ProcessMessages;
      form25.show;
      application.ProcessMessages;
      form26.Show;
      application.ProcessMessages;
      form27.show;
      application.ProcessMessages;
      form28.Show;
      application.ProcessMessages;
      cp.show;
      application.ProcessMessages;
end;

procedure TForm1.Button59Click(Sender: TObject);
begin
 button14Click(self);
end;

procedure TForm1.CheckBox51Click(Sender: TObject);
var s_state:boolean;
begin
 s_state:=(checkbox55.Checked  and  checkbox47.Checked);
 if checkbox51.checked then button60Click(self);
 if (not checkbox12.Checked) and s_state then
 begin
    checkbox55.Checked:=s_state;
    checkbox47.Checked:=s_state;
 end;
 //if (checkbox12.checked and checkbox47.Checked) then
 //   aho_sonogram2
 //else
 //   if checkbox12.checked then sonogram2;
 button14Click(self);
end;

procedure TForm1.Button58Click(Sender: TObject);
var i,j,k:integer;
    bitmapfile:string;
    bitmaploaded:string;
    extnofclusters:integer;
    extnofsylls:integer;
    testpar:integer;
    extfiletime:double;
    extsylltime:double;
    extbitmaptime:double;
    extmsecinday:int64;
    extstartpixel:integer;
    extendpixel:integer;
    extpixelwidth:integer;
    tempname:string;
    resolution:double;
    bmpsize:array[0..maxclusters] of integer;
    bmpheights:array[0..maxclusters] of integer;
    scx,scy:array[0..maxclusters] of integer;
    syllablecount:array[0..maxclusters] of integer;
    exttotalwidth:array[0..maxclusters] of integer;
    bmpwidth,cluster,rowsneeded,heightneeded:integer;
    cbmp:Tbitmap32;
    cx:array[0..maxclusters] of integer;
    cy:array[0..maxclusters] of integer;
    T1,T2,freq:int64;
    elapsed:double;
    abmp:Tbitmap32;
    bwritten:integer;
    pixelval:byte;
    pixelvalarray:array of byte;
    x,y:integer;
    syltime:integer;
    w,h:smallint;
    pixelpointer:integer;
    specdat:array[1..1] of specdata;
    savesort:file of byte;
    outcluster:byte;
    tempfile:string;
    extension:string;
begin
 loadingexternaldata:=true;
  queryperformancefrequency(freq);

  //first, get a list of files in the current directory
  //this should be stored in a CSV file
  //for testing purposes, this is produec in the cluster mudule
  //for real external data (soundanalysis pro) this must be produced...how exactly??
  //also, we should already have the bitmaps at this point......

  //let's  first read the CSV file into form30

  form30.advspreadgrid1.clear;
  form30.advspreadgrid1.rowcount:=0;
  if opendialog5.execute then
  begin
           extension:=uppercase(ExtractfileExt(opendialog5.FileName));
           if (extension<>'.CSV') and (extension<>'.XLS')  then
           begin
              Showmessage('Oh Sh*t.....Unknown File Extension! (.CSV, .XLS)');
           end;
           if extension='.CSV' then
           begin
             form30.advspreadgrid1.loadfromCSV(opendialog5.filename);
             Filepath:=PathWithoutRightElement(opendialog5.filename,'\');
           end;
           if (extension='.XLS')  then
           begin
             form30.advspreadgrid1.LoadFromXLS(opendialog5.filename);
             Filepath:=PathWithoutRightElement(opendialog5.filename,'\');
           end;
  end;
  application.ProcessMessages;
  form30.Button1.Enabled:=false;
  form30.show;
  queryperformancecounter(T1);

  form30.advspreadgrid1.colWidths[1]:=120;
  form30.advspreadgrid1.SortSettings.Column:=1;
  form30.advspreadgrid1.QSort;
  for i:=form30.advspreadgrid1.rowcount-1 downto 0 do
   if form30.advspreadgrid1.cells[0,i]='' then form30.advspreadgrid1.removerows(i,1);

  abmp:=Tbitmap32.create;

  //quickly load first bitmap:neede to set height of imgview26
  tempname:=PathWithoutRightElement(form30.advspreadgrid1.cells[1,0],'.');
  bitmapfile:=tempname+'.bmp';
  abmp.LoadFromFile(bitmapfile);

  //count number of clusters
  extnofclusters:=0;
  extnofsylls:=0;
  form30.advspreadgrid1.rowcount:=form30.advspreadgrid1.rowcount+5;
  for i:=0 to form30.advspreadgrid1.rowcount-1 do
  begin
   if form30.advspreadgrid1.cells[0,i]<>'' then
   begin
    inc(extnofsylls);
    testpar:=strtoint(form30.advspreadgrid1.cells[0,i]);
    if testpar>extnofclusters then extnofclusters:=testpar;
   end;
  end;

  //calculate bitmap metrics:
  //totalwidth -> rows,columns needed on each cluster bitmap;
  //haal dit uit de clustering zelf

   for i:=0 to extnofclusters do bmpsize[i]:=0;
   for i:=0 to extnofclusters do syllablecount[i]:=0;
   for i:=0 to extnofclusters do exttotalwidth[i]:=0;
   for i:=0 to extnofclusters do cx[i]:=2;
   for i:=0 to extnofclusters do cy[i]:=2;
   for i:=1 to form30.advspreadgrid1.rowcount-1 do
   begin
    if form30.advspreadgrid1.cells[0,i]<>'' then
    begin
       cluster:=strtoint(form30.advspreadgrid1.cells[0,i-1]);
       bmpwidth:=strtoint(form30.advspreadgrid1.cells[3,i-1]);
       bmpsize[cluster]:=bmpsize[cluster]+bmpwidth+5;
       inc(syllablecount[cluster]);
    end;
   end;
   //
   rxspinedit77.MinValue:=0;
   rxspinedit77.MaxValue:=extnofclusters;
   //
   for j:=0 to extnofclusters do
   begin
      rowsneeded:=2+(bmpsize[j] div imgview325.width) div 2;
      bmpheights[j]:=trunc(0.60*rowsneeded*((abmp.height)+5));
      if (bmpheights[j]<600) and (syllablecount[j]>0) then bmpheights[j]:=600;
      if (syllablecount[j]=0) then bmpheights[j]:=0;
   end;
   //
   //setlength(extarea,extnofclusters+1);
   //for i:=0 to extnofclusters do
   //begin
   //    if (syllablecount[i]+1)>0 then
   //                setlength(extarea[i],syllablecount[i]+1);
   //end;
   //
   for i:=0 to extnofclusters do
   begin
       //showbmp[i]:=Tbitmap32.Create;
       showbmp[i].SetSize(imgview325.Width,bmpheights[i]);
       showbmp[i].Clear(clwhite32);
   end;

  //a short test;
  form30.AdvSpreadGrid1.ShowSelection:=true;
  bitmaploaded:='';
  cbmp:=Tbitmap32.create;
  cbmp.SetSize(10,10);
  cbmp.Clear(clwhite32);

  setlength(extareatrack,extnofsylls+1);

  //open idb file here
  assignfile(extidb,filepath+'\'+'images_external.db');
  rewrite(extidb,1);
  idb_written:=0;


  //open Dat file here
  assignfile(extspec,filepath+'\'+'spectra_external.dat');
  rewrite(extspec,sizeof(specdata));
  speccols:=false;
  spec_written:=0;
  for k:=1 to 1000 do specdat[1].Data[k]:=0;

  assignfile(savesort,filepath+'\'+'save_external_result.bin');
  rewrite(savesort);

  bitmaploaded:='';
  for i:=1 to extnofsylls do
  begin
     //form30.Caption:=inttostr(i); form30.Update;
     //sleep(10);
     //if i=75 then beep ;

     tempfile:=form30.advspreadgrid1.cells[1,i-1];
     tempname:=PathWithoutRightElement_RFJ(tempfile,'.');
     bitmapfile:=tempname+'.bmp';
     if not fileexists(bitmapfile) then showmessage('Can not find '+bitmapfile);
     if (bitmaploaded<>bitmapfile) and fileexists(bitmapfile) then
     begin
      //imgview326.Bitmap.SaveToFile(bitmaploaded+'_processed.bmp');
      abmp.LoadFromFile(bitmapfile);
      bitmaploaded:=bitmapfile;
      imgview326.Bitmap.assign(abmp);
      imgview326.Update;
      //
      wav_in:=wavefile.create; succes:=false;
      wav_in.OpenForRead(tempfile,succes);
      if not succes then showmessage('error reading file ');
      if succes then rate:=wav_in.SamplingRate;
      wav_in.free;
     end;
     //form30.AdvSpreadGrid1.Selectrows(i-1,1);
     form30.AdvSpreadGrid1.ScrollInView(0,i-1);

     //Calculate the time
     //44 points resolution assumed
     //resolution:=1000*44/22026;  //msec
     //resolution:=1000*44/22050;  //msec
     resolution:=(44*1000)/(rate div 2);

     extmsecinday:=filename2msecinday(tempname);  //<<<<<<<<<<<<<<<<<<<<<<<
     extbitmaptime:=strtofloat(form30.advspreadgrid1.cells[2,i-1]);
     extsylltime:=extbitmaptime-extmsecinday;
     extstartpixel:=trunc(extsylltime/resolution);
     //extstartpixel:=extstartpixel-8;  //why is this needed?
     extpixelwidth:=strtoint(form30.advspreadgrid1.cells[3,i-1]);
     extendpixel:=extstartpixel+extpixelwidth;

     cbmp.SetSize(extpixelwidth+1,abmp.Height+1);
     cbmp.Draw(0,0,rect(extstartpixel,0,extendpixel,abmp.Height-1),abmp);

     imgview326.Bitmap.VertLineS(extstartpixel,0,imgview326.Bitmap.Height-1,clblue32);
     imgview326.Bitmap.VertLineS(extendpixel,0,imgview326.Bitmap.Height-1,clblue32);
     imgview326.update;

     //WE NEED TO DIMENSION THESE ARRAYS
     //keep track of what goes where


     cluster:=strtoint(form30.advspreadgrid1.cells[0,i-1]);
     inc(extareacounter[cluster]);
     extarea[cluster,extareacounter[cluster]].topleft.X:=cx[cluster];
     extarea[cluster,extareacounter[cluster]].topleft.y:=cy[cluster];
     extarea[cluster,extareacounter[cluster]].bottomright.x:=cx[cluster]+(cbmp.Width div 2);
     extarea[cluster,extareacounter[cluster]].bottomright.y:=cy[cluster]+(cbmp.height div 2);
     extarea[cluster,extareacounter[cluster]].cluster:=j;
     extarea[cluster,extareacounter[cluster]].item:=i;  //bmppointer;
     extarea[cluster,extareacounter[cluster]].place:=0 ;//i; waar was dit voor???
     extareatrack[i]:=extareacounter[cluster]; //reverse lookup;

     //

     // now, copy cbmp to the cluster bitmaps;
     cluster:=strtoint(form30.advspreadgrid1.cells[0,i-1]);
     cbmp.DrawTo(showbmp[cluster],rect(cx[cluster],cy[cluster],cx[cluster]+extpixelwidth div 2,cy[cluster]+abmp.Height div 2));

     //showbmp[cluster].SaveToClipboard;
     //imgview325.Bitmap.assign(showbmp[cluster]);
     //imgview325.Update;
     //form1.Update;

     cx[cluster]:=cx[cluster]+extpixelwidth div 2+2;
     if (cx[cluster]+extpixelwidth div 2)>showbmp[cluster].Width then
     begin
        cx[cluster]:=2;
        cy[cluster]:=cy[cluster]+abmp.Height div 2+2;
     end;
     //application.ProcessMessages;
     //

     //write DAT, DB en SAVERESULT FILES.
     //First, DB
     syltime:=round(extbitmaptime);
     w:=cbmp.width-1;
     h:=cbmp.height-1;
     blockwrite(extidb,syltime,4,bwritten);
     blockwrite(extidb,w,2,bwritten);
     blockwrite(extidb,h,2,bwritten);
     if (w*h)>high(pixelvalarray) then setlength(pixelvalarray, w*h);
     //setlength(cdata,w);
     pixelpointer:=-1;
     for x:=0 to w-1 do
     begin
       for y:=0 to h-1 do
       begin
          inc(pixelpointer);
          if pixelpointer<(w*h) then pixelvalarray[pixelpointer]:=redcomponent(cbmp.Pixel[x,y]);
       end;
     end;
     blockwrite(extidb,pixelvalarray[0],(w*h),bwritten);
     inc(idb_written);
     //label87.caption:=inttostr(idb_written);

     //Next:DAT data
     specdat[1].Time:=extbitmaptime;
     specdat[1].Duration:=extpixelwidth;  // in pixels
     specdat[1].Filename:=form30.advspreadgrid1.cells[1,i-1];
     blockwrite(extspec,specdat[1],1,bwritten);

     //Next:BIN (SAVERESULT)
     outcluster:=cluster;
     blockwrite(savesort,outcluster,1);
     //
     //cleanup
     cbmp.SetSize(0,0);
     //setlength(pixelvalarray, 0);

  end;
  //close idb file here

  closefile(extidb);
  closefile(extspec);
  closefile(savesort);

  queryperformancecounter(T2);
  elapsed:=1000*(t2-t1)/freq;
  label113.caption:=inttostr(round(elapsed));
  for i:=0 to extnofclusters do
  begin
     showbmp[i].SaveTofile(inttostr(i)+'.bmp');
     showbmp[i].SetSize(0,0);
  end;
  cbmp.Free;
  abmp.free;
  rxspinedit77change(self);
  setlength(pixelvalarray, 0);
 loadingexternaldata:=false;
end;

procedure Tform1.info2spreadsheet;
var timestring:string;
    secinday,secinweek,secinmonth,secinyear:int64;
    nofunderscores:integer;
    col,row:integer;
begin
 row:=0;
 col:=0;
 advstringgrid1.cells[col,row]:=currentfile;

 col:=col+1;
 advstringgrid1.cells[col,row]:=inttostr(slide[echannel].Position);

 col:=col+1;
 advstringgrid1.cells[col,row]:=inttostr(trunc(rxspinedit34.value));
 col:=col+1;
 advstringgrid1.cells[col,row]:=inttostr(trunc(rxspinedit35.value));
 col:=col+1;
 advstringgrid1.cells[col,row]:=inttostr(trunc(rxspinedit36.value));
 col:=col+1;
 advstringgrid1.cells[col,row]:=inttostr(trunc(rxspinedit24.value));


 nofunderscores:=z_ItemCCount(currentfile,'_')-1;
 if nofunderscores=2 then
 begin
   timestring:=z_ItemCGetFmTo(currentfile,1,1,'_');
   if timestring<>'' then
   begin
     Hrs:=z_SMiddle(Timestring,1,2);
     Min:=z_SMiddle(Timestring,3,2);
     Sec:=z_SMiddle(Timestring,5,2);
   end;

   timestring:=z_ItemCGetFmTo(currentfile,2,2,'_');
   if (timestring='.WAV') or (timestring='.wav') then timestring:='';
   if timestring<>'' then
   begin
     Day:=z_SMiddle(Timestring,1,2);
     Month:=z_SMiddle(Timestring,3,2);
     Year:=z_SMiddle(Timestring,5,2);
   end;

   col:=col+1;
   advstringgrid1.cells[col,row]:='SecinDay';
   SecinDay:=(strtoint(sec)+(60*strtoint(min))+(3600*strtoint(hrs)));
   advstringgrid1.cells[col+1,row]:=inttostr(secinday);

   col:=col+1;
   advstringgrid1.cells[col,row]:='Hrs';
   advstringgrid1.cells[col+1,row]:=Hrs;

   col:=col+1;
   advstringgrid1.cells[col,row]:='Min';
   advstringgrid1.cells[col+1,row]:=Min;

   col:=col+1;
   advstringgrid1.cells[col,row]:='Sec';
   advstringgrid1.cells[col+1,row]:=Sec;

   col:=col+1;
   advstringgrid1.cells[col,row]:='Day';
   advstringgrid1.cells[col+1,row]:=Day;

   col:=col+1;
   advstringgrid1.cells[col,row]:='Month';
   advstringgrid1.cells[col+1,row]:=Month;
   //advstringgrid1.cells[2,row]:=dayofweek

   col:=col+1;
   advstringgrid1.cells[col,row]:='Year';
   advstringgrid1.cells[col+1,row]:='20'+Year;

   row:=row+1;
 end;
end;


procedure TForm1.Splitter3Moved(Sender: TObject);
begin
 rfjchart8.keepdata:=true;
 rfjchart8.setuptraces;
 rfjchart8.drawaxes;
 rfjchart8.update;
 rfjchart8.keepdata:=false;
 rfjchart9.keepdata:=true;
 rfjchart9.setuptraces;
 rfjchart9.drawaxes;
 rfjchart9.update;
 rfjchart9.keepdata:=false;
end;

{
procedure TForm1.rfjChart9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
var trace:integer;
    bmpx,bmpy:integer;
    bmpxtime:double;
    bmpyval:double;
begin

    if form3.Visible then
    begin
     bmpxtime:=rfjchart9.xpos2val(x,y);
     bmpx:=trunc(((bmpxtime-rfjchart9.start)/(rfjchart9.eind-rfjchart9.start))*fbmp2.width);
     bmpyval:=rfjchart9.ypos2val(x,y);
     bmpy:=fbmp2.height-trunc(((bmpyval-rfjchart9.trace[1].ygmin)/(rfjchart9.trace[1].ygmax-rfjchart9.trace[1].ygmin))*fbmp2.height);
     form3.Label6.caption:=inttostr(redcomponent(fbmp2.PixelS[bmpx,bmpy]));
     form3.Label2.caption:=floattostrf(rfjchart9.xpos2val(x,y)-form3.xoffset[trace],fffixed,6,2);
     form3.Label4.caption:=floattostr(rfjchart9.ypos2val(x,y));
    end;
    if checkbox20.Checked then
    begin
      rfjchart9.update;
      rfjchart9.chart.Bitmap.lines(x,1,x,rfjchart9.chart.height-1,clred32);
      rfjchart9.chart.Bitmap.lines(1,y,rfjchart9.chart.width-1,y,clred32);

      rfjchart8.update;
      rfjchart8.chart.Bitmap.lines(x,1,x,rfjchart8.chart.height-1,clred32);
      rfjchart8.chart.Bitmap.lines(1,y,rfjchart8.chart.width-1,y,clred32);
    end;
end;
}

{
procedure TForm1.rfjChart8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
var trace:integer;
    bmpx,bmpy:integer;
    bmpxtime:double;
    bmpyval:double;
begin
    if checkbox20.Checked then
    begin
      rfjchart9.update;
      rfjchart9.chart.Bitmap.lines(x,1,x,rfjchart9.chart.height-1,clred32);
      rfjchart9.chart.Bitmap.lines(1,y,rfjchart9.chart.width-1,y,clred32);
      rfjchart8.update;
      rfjchart8.chart.Bitmap.lines(x,1,x,rfjchart8.chart.height-1,clred32);
      rfjchart8.chart.Bitmap.lines(1,y,rfjchart8.chart.width-1,y,clred32);
    end;
    if form3.Visible then
    begin
     bmpxtime:=rfjchart8.xpos2val(x,y);
     bmpx:=trunc(((bmpxtime-rfjchart8.start)/(rfjchart8.eind-rfjchart8.start))*fbmp2.width);
     bmpyval:=rfjchart8.ypos2val(x,y);
     bmpy:=fbmp2.height-trunc(((bmpyval-rfjchart8.trace[1].ygmin)/(rfjchart8.trace[1].ygmax-rfjchart8.trace[1].ygmin))*fbmp2.height);
     form3.Label6.caption:=inttostr(redcomponent(fbmp2.PixelS[bmpx,bmpy]));
     form3.Label2.caption:=floattostrf(rfjchart8.xpos2val(x,y)-form3.xoffset[trace],fffixed,6,2);
     form3.Label4.caption:=floattostr(rfjchart8.ypos2val(x,y));
    end;
end;
}

{
procedure TForm1.rfjChart9click(Sender: TObject);
var button:Tmousebutton;
    m:Tmouse;
begin
    //if checkbox20.Checked then
    //begin
    //  rfjchart2.bmp.lines(mousedownx,1,mousedownx,rfjchart2.bmp.height-1,clred32);
    //  rfjchart2.update;
    //end;
    if form3.CheckBox2.checked then
     begin
       rfjchart9.marksize:=trunc(rxspinedit14.value);
       rfjchart9.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart9.update;
       rfjchart8.marksize:=trunc(rxspinedit14.value);
       rfjchart8.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart8.update;
    end;
end;
}

{
procedure TForm1.rfjChart8click(Sender: TObject);
var button:Tmousebutton;
    m:Tmouse;
begin
    if form3.CheckBox2.checked then
     begin
       rfjchart9.marksize:=trunc(rxspinedit14.value);
       rfjchart9.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart9.update;
       rfjchart8.marksize:=trunc(rxspinedit14.value);
       rfjchart8.setmark(1,strtofloat(form3.Label2.caption),strtoint(form3.Label4.caption));
       rfjchart8.update;
    end;
end;
}

procedure TForm1.RxSpinEdit38Change(Sender: TObject);
begin
  if checkbox12.Checked then  button14Click(self);
end;

procedure TForm1.CheckBox55Click(Sender: TObject);
begin
 if checkbox54.Checked then
    checkbox54.Checked:=not checkbox55.checked;
end;

procedure TForm1.CheckBox54Click(Sender: TObject);
begin
  if checkbox55.Checked then
     checkbox55.Checked:=not checkbox54.checked;
end;

procedure TForm1.GroupBox18Click(Sender: TObject);
var helpfile:string;
begin
  helpfile:=programhome+'\scaling.htm';
  if fileExists(helpfile) then
  begin
    //form13.htmllite1.LoadFromFile(helpfile);
    //form13.show;
  end;
end;

procedure TForm1.GroupBox22Click(Sender: TObject);
var helpfile:string;
begin
  helpfile:=programhome+'\scaling.htm';
  if fileExists(helpfile) then
  begin
    //form13.htmllite1.LoadFromFile(helpfile);
    //form13.show;
  end;
end;

procedure TForm1.Button60Click(Sender: TObject);
begin
 checkbox55.Checked:=true;
 checkbox47.Checked:=true;
end;

procedure TForm1.BitBtn17Click(Sender: TObject);
var i:integer;
begin
    //if (not Zip) then
     for i:=1 to advspreadgrid1.RowCount-1 do
     begin
       if checkbox63.checked then
       begin
        //count
        if advspreadgrid1.Cells[3, i]<>'' then
        begin
          if checkbox57.Checked and (strtofloat(advspreadgrid1.Cells[3, i])<rxspinedit40.value) then advspreadgrid1.Cells[1, i]:='Print';
          if checkbox59.Checked and (strtofloat(advspreadgrid1.Cells[3, i])>rxspinedit42.value) then advspreadgrid1.Cells[1, i]:='Print';
        end;
        //size
        if advspreadgrid1.Cells[2, i]<>'' then
        begin
          if checkbox60.Checked and (strtoint(advspreadgrid1.Cells[2, i])<rxspinedit43.value) then advspreadgrid1.Cells[1, i]:='Print';
          if checkbox61.Checked and (strtoint(advspreadgrid1.Cells[2, i])>rxspinedit44.value) then advspreadgrid1.Cells[1, i]:='Print';
        end;
       end;
       if not checkbox63.checked then
       begin
        //count
        if advspreadgrid1.Cells[3, i]<>'' then
        begin
          if checkbox57.Checked and (strtofloat(advspreadgrid1.Cells[3, i])<rxspinedit40.value) then advspreadgrid1.Cells[1, i]:='Delete';
          if checkbox59.Checked and (strtofloat(advspreadgrid1.Cells[3, i])>rxspinedit42.value) then advspreadgrid1.Cells[1, i]:='Delete';
        end;
        //size
        if advspreadgrid1.Cells[2, i]<>'' then
        begin
          if checkbox60.Checked and (strtoint(advspreadgrid1.Cells[2, i])<rxspinedit43.value) then advspreadgrid1.Cells[1, i]:='Delete';
          if checkbox61.Checked and (strtoint(advspreadgrid1.Cells[2, i])>rxspinedit44.value) then advspreadgrid1.Cells[1, i]:='Delete';
        end;
       end;
     end;
end;

procedure TForm1.Button61Click(Sender: TObject);
begin
 label52.caption:='';
 label52.Update;
 toolwindow9715.show;
 pagecontrol3.activepage:= pagecontrol3.Pages[8];
end;

procedure TForm1.TabSheet21Show(Sender: TObject);
begin
  label52.caption:='';
  label52.Update;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var i:integer;
begin
deletefile('$$$.wav');
 deletefile('wavcount.wav');
 deletefile('soundimages.db');
 TerminateProcess( getCurrentProcess, 0 );
end;

procedure TForm1.CheckBox56Click(Sender: TObject);
var checkstate:boolean;
    realfilename:string;
begin

 if fileread then
 begin
   //checkstate:=checkbox26.Checked;
   //checkbox26.Checked:=true;
   fileread:=false;
   env_calc:=false;
   recalcsonogram:=true;
   realfilename:=currentfile;
   currentfile:=opendialog1.FileName;
   if not fileread then showwave;
   StartLPfilter;
   if checkbox10.Checked then LPfilter;
   currentfile:=realfilename;
    begin
           chart;
           if (pagecontrol1.ActivePage=tabsheet2) and checkbox9.checked then count2;
           if (pagecontrol1.ActivePage=tabsheet1) and checkbox8.checked then count;
           application.ProcessMessages;
           if checkbox7.Checked then if checkbox47.Checked then aho_sonogram2 else sonogram2;
    end;
   //checkbox26.Checked:=checkstate;
 end;
 if checkbox56.Checked then rxspinedit4.value:=rxspinedit4.value/ 2 else rxspinedit4.value:=rxspinedit4.value*2;
 label47.caption:='= '+floattostrf(rxspinedit4.value*(1000/rate),ffgeneral,2,2)+' msec';
 application.ProcessMessages;
 if not clustering then showwave;
 recalcsonogram:=true;
 env_calc:=false;
 if not clustering then chart2;
end;

procedure TForm1.CheckBox58Click(Sender: TObject);
begin
   if checkbox58.Checked then rxspinedit4.value:=rxspinedit4.value/4 else rxspinedit4.value:=rxspinedit4.value*4;
   application.ProcessMessages;
   showwave;
   recalcsonogram:=true;
   env_calc:=false;
   chart2;
end;

procedure TForm1.CheckBox62Click(Sender: TObject);
var smallbmp:Tbitmap32;
begin
 checkbox69.Checked:=checkbox62.Checked;
 checkbox2.Checked:=checkbox62.Checked;
 if checkbox62.Checked then smallpreview;
end;

procedure TForm1.ImgView322MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer; Layer: TCustomLayer);
var bmpx,bmpy:integer;
begin
   bmpy:=trunc(imgview322.VScroll.position+y);
   bmpx:=trunc(imgview322.HScroll.position+x);
   sumclickcol:=1+(bmpx div round(rxspinedit41.value+5));
   sumclickrow:=1+(bmpy div round(rxspinedit45.value+5));
   sumclicknumber:=sumclickcol+((sumclickrow-1)*trunc(rxspinedit46.value));
   //form1.caption:=inttostr(x)+', '+inttostr(bmpy)+', '+sumlist[sumclicknumber]+', '+inttostr(sumclicknumber)+', '+inttostr(sumclickcol)+', '+inttostr(sumclickrow);
   //(col-1)*(rr+5),5+(row-1)*(cc+5)
end;

procedure TForm1.ImgView322Click(Sender: TObject);
begin
  if advspreadgrid1.Cells[1,sumlistlookup[sumclicknumber]]='' then
       advspreadgrid1.Cells[1,sumlistlookup[sumclicknumber]]:='MARK'
  else
       advspreadgrid1.Cells[1,sumlistlookup[sumclicknumber]]:=''
end;

procedure TForm1.ImgView322DblClick(Sender: TObject);
begin
 //if savepicturedialog1.execute then imgview322.Bitmap.SaveToFile(savepicturedialog1.filename);
end;

procedure TForm1.Button62Click(Sender: TObject);
begin
    imgview322.bitmap.setsize(100,100);
end;

procedure TForm1.Button63Click(Sender: TObject);
var checkstate:boolean;
    realfilename:string;
begin
 if fileread then
 begin
   checkstate:=checkbox26.Checked;
   checkbox26.Checked:=true;
   fileread:=false;
   env_calc:=false;
   recalcsonogram:=true;
   realfilename:=currentfile;
   currentfile:=opendialog1.FileName;
   if not fileread then showwave;
   StartLPfilter;
   LPfilter;
   currentfile:=realfilename;
    begin
           chart;
           if (pagecontrol1.ActivePage=tabsheet2) and checkbox9.checked then count2;
           if (pagecontrol1.ActivePage=tabsheet1) and checkbox8.checked then count;
           application.ProcessMessages;
           if checkbox7.Checked then if checkbox47.Checked then aho_sonogram2 else sonogram2;
    end;
   checkbox26.Checked:=checkstate;
 end;
end;

procedure TForm1.printsummary(page:integer);
var dst,src:Trect;
    pratio:double;
    bratio:double;
    onepage:integer;
    pages:integer;
    i:integer;
    pcopy:Tbitmap32;
    leftover:integer;
begin
  onepage:=trunc(rxspinedit19.value);
  pcopy:=Tbitmap32.create;
  //if printersetupdialog1.execute then
   with printer do
   begin
      pages:=ceil(imgview322.bitmap.height/onepage);
      begindoc;
      i:=page ;
      //for i:=1 to pages do
       begin
         leftover:=imgview322.bitmap.height-(pages-1)*onepage;
         pratio:=printer.PageHeight/printer.PageWidth;
         bratio:=onepage/imgview322.bitmap.width;
         case combobox7.itemindex of
           0: imgview322.bitmap.StretchFilter:=sfnearest;
           1: imgview322.bitmap.StretchFilter:=sflinear;
           2: imgview322.bitmap.StretchFilter:=sfSpline;
           3: imgview322.bitmap.StretchFilter:=sfLanczos;
           4: imgview322.bitmap.StretchFilter:=sfMitchell;
        end;
         /////////////////////////////////////////////////////
         pcopy.setsize(imgview322.bitmap.width,onepage);
         pcopy.Clear(clwhite32);

         if i=pages then
            src:=rect(0,(i-1)*onepage,imgview322.bitmap.width,leftover+(i-1)*onepage)
         else
            src:=rect(0,(i-1)*onepage,imgview322.bitmap.width,i*onepage);

         if i=pages then
              dst:=rect(0,0,pcopy.width,leftover)
         else
              dst:=rect(0,0,pcopy.width,pcopy.height);

         imgview322.bitmap.drawto(pcopy,dst,src);
         //if i<pages then PrintPreview.image321.bitmap:=pcopy;
         //PrintPreview.show;
         //application.ProcessMessages;
         /////////////////////////////////////////////////////
         src:=rect(0,0,pcopy.width,pcopy.height);
         dst:=rect(0,0,printer.PageWidth,printer.PageHeight);
         pcopy.drawto(printer.canvas.handle,dst,src);
         //if i<pages then printer.NewPage;
       end;
      enddoc;
   end;
   pcopy.Free;
end;


procedure TForm1.Summarypreview(page:integer);
var dst,src:Trect;
    pratio:double;
    bratio:double;
    onepage:integer;
    pages:integer;
    i:integer;
    pcopy:Tbitmap32;
    leftover:integer;
begin
  onepage:=trunc(rxspinedit19.value);
  pcopy:=Tbitmap32.create;
  //if printersetupdialog1.execute then
   //with printer do
   begin
      pages:=ceil(imgview322.bitmap.height/onepage);
      //begindoc;
       i:=page;
      //for i:=1 to pages do
       begin
         leftover:=imgview322.bitmap.height-(pages-1)*onepage;
         pratio:=printer.PageHeight/printer.PageWidth;
         bratio:=onepage/imgview322.bitmap.width;
         case combobox7.itemindex of
           0: imgview322.bitmap.StretchFilter:=sfnearest;
           1: imgview322.bitmap.StretchFilter:=sflinear;
           2: imgview322.bitmap.StretchFilter:=sfSpline;
           3: imgview322.bitmap.StretchFilter:=sfLanczos;
           4: imgview322.bitmap.StretchFilter:=sfMitchell;
        end;
         /////////////////////////////////////////////////////
         pcopy.setsize(imgview322.bitmap.width,onepage);
         pcopy.Clear(clwhite32);

         if i=pages then
            src:=rect(0,(i-1)*onepage,imgview322.bitmap.width,leftover+(i-1)*onepage)
         else
            src:=rect(0,(i-1)*onepage,imgview322.bitmap.width,i*onepage);

         if i=pages then
              dst:=rect(0,0,pcopy.width,leftover)
         else
              dst:=rect(0,0,pcopy.width,pcopy.height);

         imgview322.bitmap.drawto(pcopy,dst,src);
         PrintPreview.image321.bitmap:=pcopy;
         PrintPreview.show;
         //application.ProcessMessages;
         /////////////////////////////////////////////////////
         //src:=rect(0,0,pcopy.width,pcopy.height);
         //dst:=rect(0,0,printer.PageWidth,printer.PageHeight);
         //pcopy.drawto(printer.canvas.handle,dst,src);
         //if i<pages then printer.NewPage;
       end;
      //enddoc;
   end;
   pcopy.Free;
end;

procedure TForm1.RxSpinEdit47Change(Sender: TObject);
begin
 imgview322.Scale:=rxspinedit47.Value;
 imgview323.Scale:=rxspinedit47.Value;
end;

procedure TForm1.Button64Click(Sender: TObject);
begin
  if openpicturedialog2.Execute then
    imgview322.Bitmap.LoadFromFile(openpicturedialog2.FileName);
end;

procedure TForm1.Button65Click(Sender: TObject);
begin
 if savepicturedialog1.execute then imgview322.Bitmap.SaveToFile(savepicturedialog1.filename);
end;

procedure TForm1.RxSpinEdit41Change(Sender: TObject);
var smallbmp:Tbitmap32;
begin
     prr:=trunc(rxspinedit41.value);
     pcc:=trunc(rxspinedit45.value);
     smallbmp:=Tbitmap32.Create;
     smallbmp.setsize(prr,pcc);
     rfjchart2.bmp.StretchFilter:=sfLanczos;
     rfjchart2.bmp.DrawTo(smallbmp,rect(0,0,smallbmp.Width-1,smallbmp.height-1));
     imgview323.bitmap.setsize(smallbmp.width,smallbmp.Height);
     smallbmp.DrawTo(imgview323.bitmap);
     smallbmp.Free;
end;

procedure TForm1.RxSpinEdit45Change(Sender: TObject);
var smallbmp:Tbitmap32;
begin
     prr:=trunc(rxspinedit41.value);
     pcc:=trunc(rxspinedit45.value);
     smallbmp:=Tbitmap32.Create;
     smallbmp.setsize(prr,pcc);
     rfjchart2.bmp.StretchFilter:=sfLanczos;
     rfjchart2.bmp.DrawTo(smallbmp,rect(0,0,smallbmp.Width-1,smallbmp.height-1));
     imgview323.bitmap.setsize(smallbmp.width,smallbmp.Height);
     smallbmp.DrawTo(imgview323.bitmap);
     smallbmp.Free;
end;

procedure Tform1.addimage(name:string);
var smallbmp:Tbitmap32;
    tempbmp:Tbitmap32;
begin
 prr:=trunc(rxspinedit41.value);
 pcc:=trunc(rxspinedit45.value);
 smallbmp:=Tbitmap32.Create;
 smallbmp.setsize(prr,pcc);
 pcols:=trunc(rxspinedit46.value);
 pbcols:=pcols*(prr+5);
 pbrows:=ceil(printcount/pCOLS)*(pcc+5);
 if (imgview322.bitmap.width<>5+pbcols) or (imgview322.bitmap.height<>5+pbrows) then
   begin
      imgview322.Bitmap.SetSize(5+pbcols,5+pbrows);
      imgview322.Bitmap.Clear(clwhite32);
      prow:=1;pcol:=0;
   end;
 case combobox7.itemindex of
       0: rfjchart2.bmp.StretchFilter:=sfnearest;
       1: rfjchart2.bmp.StretchFilter:=sflinear;
       2: rfjchart2.bmp.StretchFilter:=sfSpline;
       3: rfjchart2.bmp.StretchFilter:=sfLanczos;
       4: rfjchart2.bmp.StretchFilter:=sfMitchell;
 end;
 if checkbox65.Checked then
 begin
   tempbmp:=Tbitmap32.create;
   tempbmp:=rfjchart2.GetTraceImage(schannel);
   tempbmp.DrawTo(smallbmp,rect(0,0,smallbmp.Width,smallbmp.height));
   tempbmp.free;
 end;
 if (not checkbox65.Checked)then
 begin
    rfjchart2.bmp.DrawTo(smallbmp,rect(0,0,smallbmp.Width,smallbmp.height));
 end;
 inc(pcol);
 if pcol>pcols then
 begin
     pcol:=1;
     inc(prow);
 end;
 smallbmp.DrawTo(imgview322.bitmap,(5+(pcol-1)*(prr+5)),(5+(prow-1)*(pcc+5)));
 imgview322.Bitmap.font.color:=clred;
 imgview322.Bitmap.Textout(5+(pcol-1)*(prr+5),5+(prow-1)*(pcc+5),Name);
 smallbmp.Free;
end;

procedure Tform1.smallpreview;
var smallbmp:Tbitmap32;
begin
     prr:=trunc(rxspinedit41.value);
     pcc:=trunc(rxspinedit45.value);
     smallbmp:=Tbitmap32.Create;
     smallbmp.setsize(prr,pcc);
     case combobox7.itemindex of
       0: rfjchart2.bmp.StretchFilter:=sfnearest;
       1: rfjchart2.bmp.StretchFilter:=sflinear;
       2: rfjchart2.bmp.StretchFilter:=sfSpline;
       3: rfjchart2.bmp.StretchFilter:=sfLanczos;
       4: rfjchart2.bmp.StretchFilter:=sfMitchell;
     end;
     rfjchart2.bmp.DrawTo(smallbmp,rect(0,0,smallbmp.Width-1,smallbmp.height-1));
     imgview323.bitmap.setsize(smallbmp.width,smallbmp.Height);
     smallbmp.DrawTo(imgview323.bitmap);
     smallbmp.Free;
end;

procedure TForm1.CheckBox63Click(Sender: TObject);
begin
 checkbox2.Checked:=checkbox63.Checked;
 checkbox64.Enabled:=checkbox63.Checked;
 if checkbox63.Checked then
   checkbox63.caption:='PRINT/delete'
 else
   checkbox63.caption:='print/DELETE';
end;

procedure TForm1.RxSpinEdit46Change(Sender: TObject);
var ratio:double;
begin
    ratio:=200/150;
    rxspinedit41.value:=round(1000/rxspinedit46.value);
    rxspinedit45.value:=round(rxspinedit41.value/ratio);
    rxspinedit19.value:=1500+(rxspinedit46.value*10);
end;

procedure TForm1.CheckBox64Click(Sender: TObject);
begin
  if checkbox64.checked then
       checkbox64.Caption:='SUMMARY PRINT / normal print'
  else
       checkbox64.Caption:='summary print / NORMAL PRINT';
end;

procedure TForm1.ComboBox7Change(Sender: TObject);
begin
 smallpreview;
end;

procedure TForm1.JvThread1Execute(Sender: TObject; params: Pointer);
var f,t:string;
begin
   f:=form1.fromfile;
   t:=form1.tofile;
   filecopy(f,t,false);
   //synchronize
end;

procedure TForm1.CheckBox66Click(Sender: TObject);
begin
   if checkbox66.Checked then
    begin
      rfjchart2.DoScroll:=true;
      rfjchart2.chart.scalemode:=smnormal;
      checkbox54.checked :=false;
    end
   else
    begin
      rfjchart2.DoScroll:=false;
      rfjchart2.chart.scalemode:=smstretch;
    end;
  if not clustering then button14click(self);
end;

procedure TForm1.CheckBox67Click(Sender: TObject);
begin
  if not checkbox51.Checked then form8.LUTControl1Change(Self);
end;

procedure TForm1.RxSpinEdit48Change(Sender: TObject);
begin
  if not checkbox51.Checked then   Form8.LUTControl1Change(Self);
end;

procedure TForm1.RxSpinEdit49Change(Sender: TObject);
begin
  if not checkbox51.Checked then Form8.LUTControl1Change(Self);
end;

procedure TForm1.CheckBox68Click(Sender: TObject);
begin
  if not checkbox51.Checked then Form8.LUTControl1Change(Self);
end;

procedure TForm1.Button66Click(Sender: TObject);
begin
    rxspinedit48.Value:=0;
    rxspinedit49.Value:=255;
    if not checkbox51.Checked then Form8.LUTControl1Change(Self);
    button14Click(self);
end;


procedure TForm1.Button69Click(Sender: TObject);
var onepage:integer;
    pages,i:integer;
begin
  onepage:=trunc(rxspinedit19.value);
  pages:=ceil(form1.imgview322.bitmap.height/onepage);
  label67.caption:=inttostr(pages);
  if form1.printersetupdialog1.execute then
         for i:=1 to pages do form1.printsummary(i);
end;

procedure TForm1.Button67Click(Sender: TObject);
var onepage:integer;
    pages,i:integer;
begin
  onepage:=trunc(rxspinedit19.value);
  pages:=ceil(form1.imgview322.bitmap.height/onepage);
  label67.caption:=inttostr(pages);
  form1.Summarypreview(trunc(rxspinedit50.value));
end;

procedure TForm1.Button68Click(Sender: TObject);
var onepage:integer;
    pages,i:integer;
begin
  onepage:=trunc(rxspinedit19.value);
  pages:=ceil(form1.imgview322.bitmap.height/onepage);
  label67.caption:=inttostr(pages);
  if form1.printersetupdialog1.execute then form1.printsummary(trunc(rxspinedit50.value));
end;

procedure TForm1.RxSpinEdit50Change(Sender: TObject);
begin
  button67click(self);
end;

procedure TForm1.CheckBox69Click(Sender: TObject);
begin
 checkbox62.Checked:=checkbox69.Checked;
 checkbox2.Checked:=checkbox69.Checked;
 if checkbox69.Checked then smallpreview;
end;

procedure TForm1.History1Click(Sender: TObject);
begin
 //form2.show;
end;

procedure TForm1.ScrollButtonClick(Sender: TObject);
begin
 rxspinedit12.value:=0;
 rxspinedit13.value:=slen3;
 checkbox66.Checked:=scrollbutton.Down;
end;

procedure TForm1.CheckBox71Click(Sender: TObject);
begin
   if checkbox71.checked then
    begin
      form14.Image321.Bitmap.SetSize(form14.Image321.width,form14.Image321.height);
      form14.Show;
    end
   else form14.Hide;
end;

procedure TForm1.RxSpinEdit51Change(Sender: TObject);
begin
form1.magrect:=trunc(form1.rxspinedit51.value);
end;

procedure TForm1.Button70Click(Sender: TObject);
var i:integer;
begin
 //edit undo
 if undolevel=0 then Showmessage('No Undo Buffer File Found (UndoLevel=0)');
 if undolevel>0 then
 begin
  if checkbox36.Checked then
  begin
   ReadEbuffer(UndoLevel,Nofsamples);
   with rfjchart2 do
   begin
       erasetrace(echannel);
       trace[echannel].buffersize:=0;
       drawallaxes;
       addarray(echannel,0,1000/rate,startsample,eindsample-1,ebuffer);
       setymark(echannel,(slide[echannel].max-slide[echannel].Position));
       setymark(echannel,(slide[echannel].max-slide[echannel].Position-trunc(rxspinedit22.value)));
       env_calc:=true;
       reset;
       rfjchart2.update;
   end;
   echannel_leftscroll_change(Self);
  end;
 end;

end;

procedure Tform1.WriteEbuffer(Number:integer;Nofsamples:integer);
var Bfile:File;
    Fname:string;
    NumWritten:integer;
begin
      Fname:=''+inttostr(Number)+'.seb';
      AssignFile(Bfile, Fname);
      Rewrite(Bfile, 4);
      BlockWrite(Bfile, Ebuffer[0], Nofsamples, NumWritten);
      CloseFile(Bfile);
      if Nofsamples<>Numwritten then
      begin
        Showmessage('Error Writing BufferFile');
        Dec(UndoLevel);
        Button70.caption:='Un-edit '+inttostr(Undolevel);
      end;
end;

procedure Tform1.ReadEbuffer(Number:integer;Nofsamples:integer);
var Bfile:File;
    Fname:string;
    NumRead:integer;
begin
      Fname:=''+inttostr(Number)+'.seb';
      AssignFile(Bfile, Fname);
      Reset(Bfile, 4);
      setlength(Ebuffer,nofsamples);
      BlockRead(Bfile, Ebuffer[0], Nofsamples, NumRead);
      CloseFile(Bfile);
      if Nofsamples<>NumRead then
       begin
        Showmessage('Error Writing BufferFile');
       end
      else Dec(UndoLevel);
      Button70.caption:='Un-edit '+inttostr(Undolevel);
end;

procedure TForm1.Button71Click(Sender: TObject);
var i,j,k,l:integer;
    meanpowercount:integer;
    testhi:integer;
    maxpower:double;
    windowlength:integer;
    testval:integer;
    nosignal:boolean;
    med1,med2:array[0..4096] of integer;
    size:integer;
begin
     windowlength:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);

     rfjchart5.traces:=1;
     rfjchart5.start:=0;
     rfjchart5.eind:=trunc(rxspinedit21.value);
     rfjchart5.backcolor:=clwhite;
     rfjchart5.trace[1].xaxispen.color:=clblack;
     rfjchart5.trace[1].yaxispen.color:=clblack;
     rfjchart5.trace[1].pen.color:=clblack;
     rfjchart5.trace[1].showtitle:=true;
     rfjchart5.trace[1].ygmin:=0;
     rfjchart5.trace[1].ygmax:=2500;
     rfjchart5.trace[1].yaxislegend:='';
     rfjchart5.trace[1].clipy:=true;
     rfjchart5.drawmode:=dmbar;
     rfjchart5.setmemsize(1,windowlength);
     rfjchart5.buffered:=false;
     rfjchart5.setuptraces;
     rfjchart5.drawaxes;

   //getting the 'noise' spectrum using the gate signal
    if checkbox36.Checked then
    begin
      i:=startsample;
      meanpowercount:=0;
      testhi:=(slide[echannel].max-slide[echannel].Position);
      maxpower:=21-scrollbar6.position;//trunc(rxspinedit1.value);;
      for j:=0 to ((windowlength div 2)-2) do meanpower[j]:=0;
      while i<eindsample-1 do
      begin
        nosignal:=true;
        for k:=round(i-(windowlength div 2)) to round(i+(windowlength div 2)) do
        begin
          if (ebuffer[k]>testhi) then nosignal:=false;
        end;
        if (i>(windowlength div 2))  and (i<((slen3*rate/1000)-(windowlength div 2))) then
          if nosignal then
          begin
              //there is no signal -get spectrum at this point;
               l:=-1;
               for k:=round(i-(windowlength div 2)) to round(i+(windowlength div 2)) do
               begin
                 if (k<nofsamples) and (k>0) then
                 begin
                   inc(l);
                    slice[l]:=wavdata[k];
                 end;
               end;
               //for j:=0 to ((windowlength div 2)-2) do power[j]:=0;
               zeromemory(@power,4096*sizeof(double));
               if checkbox47.Checked then
                 AhoSpectrum(combobox6.ItemIndex,Windowlength,Power)
               else
                 Getspectrum(combobox3.ItemIndex,Windowlength,Power);

               for j:=0 to ((windowlength div 2)-2) do
               begin
                  meanpower[j]:=((meanpower[j]*meanpowercount)+power[j])/(meanpowercount+1);
               end;
               inc(meanpowercount);
          end;
          i:=i+windowlength;
      end;
    end;
    rfjchart5.setuptraces;
    rfjchart5.drawaxes;
    for k:=0 to (windowlength div 2)-2 do
    begin
                  testval:=trunc(maxpower*meanpower[k]);
                  rfjchart5.addpoint(1,k*rate/windowlength,testval);
                  med1[k]:=testval;
    end;
    rfjchart5.update;

    size:=(windowlength div 2)-2;
    Qsort(med1,med2,size);
    medianspect:=med2[size div 2];

end;

procedure TForm1.RxSpinEdit52Change(Sender: TObject);
begin
  spectrum(spectrumlastx,spectrumlasty);
end;

procedure TForm1.RxSpinEdit54Change(Sender: TObject);
begin
  spectrum(spectrumlastx,spectrumlasty);
end;

procedure TForm1.RxSpinEdit53Change(Sender: TObject);
begin
  spectrum(spectrumlastx,spectrumlasty);
end;

procedure TForm1.Button72Click(Sender: TObject);
var filename:string;
    f:file;
    outstring:string;
    i:integer;
begin
    save_bin:=true;
    //filename:='c:\temp\buffer.bin';
    //assignfile(f,filename);
    //rewrite(f,sizeof(specdata));

    assignfile(idb,'images.db');
    rewrite(idb,1);

    assignfile(spec,'spectra.dat');
    //rewrite(spec,1);
    rewrite(spec,sizeof(specdata));

    assignfile(specf,'spectra.daf');
    //rewrite(spec,1);
    rewrite(specf,sizeof(specdataF));

    echannel_leftscroll_change(self);

    imagefileisopen:=false;
    closefile(idb);
    closefile(spec);
    closefile(specf);

    save_bin:=false;
    //closefile(f);
end;

procedure TForm1.RxSpinEdit56Change(Sender: TObject);
begin
  spectrum(spectrumlastx,spectrumlasty);
end;

procedure TForm1.RxSpinEdit55Change(Sender: TObject);
begin
  spectrum(spectrumlastx,spectrumlasty);
end;

procedure TForm1.Button73Click(Sender: TObject);
var i,j:integer;
begin
   //form16.show;
   //form16.advspreadgrid1.RowCount:=peakcounter+1;
   //form16.advspreadgrid1.ColCount:=peakcounter+1;
   //for i:=1 to peakcounter-1 do form16.advspreadgrid1.Cells[i,1]:=floattostrf(abs(peakdata[i]-peakdata[i+1]),ffgeneral,4,1);
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
var windowlength:integer;
begin
 windowlength:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);
 label81.Caption:=floattostr(rate/windowlength);
 //form17.AdvSpreadGrid1.ColCount:=2+(windowlength div 2)
end;

procedure TForm1.Button74Click(Sender: TObject);
var src,dst:string;
    selectionpath,selectionpath2:string;
    fromdir,todir:string;
    move_error:boolean;
    cdir:string;
begin
  cdir:=getcurrentdir;
  selectionpath:=filepath+'\'+'select\';
  selectionpath2:=ziphome+'\'+'select'+'_'+zipname+'\';
  move_error:=false;

  if not zip then
  begin
   if not DirectoryExists(selectionpath) then
    if not CreateDir(selectionpath) then
     if not checkbox63.checked then raise Exception.Create('Cannot create '+selectionpath);
     src:='$$$.wav';
     dst:=selectionpath+advspreadgrid1.Cells[0, currentrow]+'_'+inttostr(round(rxspinedit12.value))+'-'+inttostr(round(rxspinedit13.value))+'.wav';
     if not windows.copyfile(pchar(src),pchar(dst),false) then move_error:=true;
  end;

  if Zip then
  begin
   if not DirectoryExists(selectionpath2) then
    if not CreateDir(selectionpath2) then
      if not checkbox63.checked then raise Exception.Create('Cannot create '+selectionpath2);
      src:='$$$.wav';
      dst:=selectionpath2+advspreadgrid1.Cells[0, currentrow]+'_'+inttostr(round(rxspinedit12.value))+'-'+inttostr(round(rxspinedit13.value))+'.wav';
      if not windows.copyfile(pchar(src),pchar(dst),false) then move_error:=true;
  end;

  if move_error then showmessage('An ERROR occurred during copying');
  setcurrentdir(cdir);
end;

procedure TForm1.BPfilterini;
var SampleRate:double;
    j:integer;
begin
         BPtaps:=trunc(RXspinedit59.value);
         BP_Lo_freq:=RXspinedit57.value/rate;
         BP_Hi_freq:=RXspinedit58.value/Rate;
         BPnormal:=0;
         BPWINDOW:=NSP_WINBLACKMANOPT;
         if BP_Lo_freq <BP_hi_Freq then NSPDFirBandPass(BP_Lo_Freq,BP_hi_freq,@BPCoeff,BPtaps,BPwindow,BPnormal);
         NSPDfirINIT(@BPCoeff,BPTaps,nil,BPchannelState[1]);
end;

procedure Tform1.BPfiltersampledouble(var sample:double);
var temp:double;
begin
          Temp:=nspdFir(BPchannelState[1],Sample);
          Sample:=Temp;
end;

procedure TForm1.Button75Click(Sender: TObject);
var start,eind:double;
begin
  start:=rxspinedit12.value;
  eind:=rxspinedit13.value;
  showwave;
  rxspinedit12.value:=start;
  rxspinedit13.value:=eind;
  button14click(self);
end;

procedure TForm1.CheckBox74Click(Sender: TObject);
begin
 if not checkbox74.checked then button75click(self);
end;

procedure TForm1.CheckBox73Click(Sender: TObject);
var points:integer;
begin
 if checkbox73.Checked then
  begin
    button4.Enabled:=false;
    advspreadgrid1.SortSettings.Column:=4;
    advspreadgrid1.SortSettings.Direction:=sdascending;
    advspreadgrid1.QSort;
    checkbox36.Checked:=true;
    //application.ProcessMessages;
    checkbox2.Checked:=true;
    //application.ProcessMessages;
    scrollbutton.Down:=true;
    checkbox66.Checked:=true;
    //application.ProcessMessages;
    checkbox53.Checked:=false;
    //application.ProcessMessages;
    if rxspinedit6.value<15 then rxspinedit6.value:=15;
    //application.ProcessMessages;

    //turned off on request RFJ 2012
    //checkbox10.Checked:=true;

    //application.ProcessMessages;
    combobox5.ItemIndex:=2;
    //application.ProcessMessages;
    combobox1.ItemIndex:=5;
    //application.ProcessMessages;
    points:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);
    //application.ProcessMessages;
    rxspinedit24.value:=ceil(1000*points/rate);
    //application.ProcessMessages;

    //turned off on request RFJ 2012
    //checkbox56.Checked:=true;
    //need this to keep it working
    if not clustering then showwave;
    recalcsonogram:=true;
    env_calc:=false;
    if not clustering then chart2;

    application.ProcessMessages;
    button4.Enabled:=true;
  end;
 if not checkbox73.Checked then
  begin
    checkbox36.Checked:=false;
    application.ProcessMessages;
    checkbox2.Checked:=false;
    //application.ProcessMessages;
    scrollbutton.Down:=false;
    checkbox66.Checked:=false;
    application.ProcessMessages;
    checkbox53.Checked:=false;
    application.ProcessMessages;
    rxspinedit6.value:=16;
    application.ProcessMessages;
    checkbox10.Checked:=false;
    application.ProcessMessages;
    combobox5.ItemIndex:=2;
    application.ProcessMessages;
    combobox1.ItemIndex:=6;
    application.ProcessMessages;
    points:=strtoint(combobox5.Items.strings[combobox5.ItemIndex]);
    application.ProcessMessages;
    rxspinedit24.value:=ceil(1000*points/rate);
    application.ProcessMessages;
    checkbox56.Checked:=false;
    application.ProcessMessages;
  end;
end;

procedure TForm1.Button76Click(Sender: TObject);
begin
 memo4.lines.SaveToFile('processing.csv');;
end;

procedure TForm1.JvTimeLimit1Expire(Sender: TObject);
begin
  application.terminate;
end;

procedure TForm1.CheckBox75Click(Sender: TObject);
begin
 if checkbox75.Checked then
 begin
   checkbox76.Checked:=false;
   checkbox77.Checked:=false;
 end;
end;

procedure TForm1.CheckBox76Click(Sender: TObject);
begin
 if checkbox76.Checked then
 begin
     checkbox75.Checked:=false;
     checkbox77.Checked:=false;
 end;
end;

procedure TForm1.CheckBox77Click(Sender: TObject);
begin
 if checkbox77.Checked then
 begin
   checkbox75.Checked:=false;
   checkbox76.Checked:=false;
 end;
end;

procedure TForm1.CheckBox78Click(Sender: TObject);
begin
   if (rxspinedit16.Value>0) and checkbox78.checked then
  begin
    showwave;
    button59click(self);
  end;
end;


procedure TForm1.Button77Click(Sender: TObject);
begin
    rfjchart2.dumpdata(1,'1.txt');
end;

procedure TForm1.RadioGroup5Click(Sender: TObject);
begin
   fileread:=false;
   processfile;
end;

procedure TForm1.Button78Click(Sender: TObject);
begin
  form22.Show;
  form1.Show;
end;

procedure TForm1.Button79Click(Sender: TObject);
begin
  printscreen;
end;

procedure TForm1.Button80Click(Sender: TObject);
var imagenumber,i:integer;
    time:integer;
    bytesread:integer;
    width,height:integer;
    x,y:integer;
    pixel:integer;
    maxwidth:integer;
    freq,t1,t2:int64;
    elapsed:double;
    p:integer;
    bit:array of byte;
    totalmem:int64;
    mem:integer;
    size:integer;
    idbimgpointer:int64;
    l:integer;
    dbfileroot:string;
    testbmp32:Tbitmap32;
    timercounter:integer;
    totalcounter:integer;
begin
 for i:=0 to 250 do
 begin
      deletefile(filepath+'\cluster_'+inttostr(i)+'.bmp');  //rfj
 end;

 usedisk:=useharddisk.Checked;
 usemem:=not usedisk;

 clustering:=true;
 if checkbox73.Checked=true then checkbox73.Checked:=false;
 fileread:=false;
 save_result:=false;
 for i:=0 to maxclusters do
 begin
      showbmp[i].SetSize(0,0);
 end;
 setlength(idbimg,0);
 setlength(bit,0);

 loading_db:=true;
 rxspinedit60.value:=1;
 leftmousebutton:=false;
 rightmousebutton:=false;
 rxspinedit71.Value:=0;
 if imagefileisopen then closefile(idb);
 opendialog1.Filter:='DB Files|*.DB';
 if opendialog1.Execute then
 begin

  l:=length(opendialog1.filename);
  fileroot:=PathWithoutRightElement(opendialog1.filename,'.') ;
  Filepath:=PathWithoutRightElement(opendialog1.filename,'\');
  dbpath:=PathRightElement(form1.opendialog1.filename,'\');
  //dbfileroot:=PathWithoutRightElement(opendialog1.filename,'.') ;
  dbfile:=fileroot+'.db';
  datfile:=fileroot+'.dat';
  kmfile:=fileroot+'.km';

  memo1.Clear;
  havesum:=false;
  imgview324.Bitmap.Clear(clwhite32);
  checkbox81.checked:=false;
  idbname:=dbfile;
  imagenumber:=0;
  idbsize:=0;
  assignfile(idb,idbname);
  reset(idb,1);
  size:=filesize(idb);
  idbimgpointer:=0;
  if usemem then setlength(idbimg,size+1); //temp RFJ
  imagefileisopen:=true;
  maxwidth:=0;
  memo5.Color:=clred;
  memo5.Lines.add('Indexing Images');memo5.Update;
  queryperformancefrequency(freq);
  queryperformancecounter(t1);
  totalmem:=0;
  //form27.Memo1.Clear;
  setlength(bit,255*232);
  timercounter:=0;
  totalcounter:=0;
  if dumpbmp.checked then testbmp32:=Tbitmap32.create;                       /////
  while not eof(idb) do
   begin
    inc(imagenumber);
    inc(idbsize);
    inc(timercounter);
    inc(totalcounter);
    if timercounter=100 then
    begin
         Timer1Timer(self); //rfj july 19 2009
         button80.Caption:=inttostr(totalcounter);
         timercounter:=0;
         form1.Update;
    end;
    if imagenumber<maxrec then
    begin
     time:=0;blockread(idb,time,4,bytesread);
     idbdata[imagenumber].time:=time;

     width:=0;blockread(idb,width,2,bytesread);
     idbdata[imagenumber].width:=width;

     inc(idbimgpointer);
     if usemem then idbimg[idbimgpointer]:=width;  //temp RFJ


     //store and read from memory
     if usemem then idbdata[imagenumber].offset:=idbimgpointer;


     if width>maxwidth then
     begin
       maxwidth:=width;
       rxspinedit13.value:=maxwidth+5;
     end;
     height:=0;blockread(idb,height,2,bytesread);
     idbdata[imagenumber].height:=height;
     idbheight:=height;
     inc(idbimgpointer);

     //store and read from file
     if usedisk then idbdata[imagenumber].offset:=filepos(idb);

     if usemem then idbimg[idbimgpointer]:=height; //temp RFJ

     if dumpbmp.checked then testbmp32.setsize(width,height);                      ////

     setlength(bit,width*height);
     blockread(idb,bit[0],(width*height),bytesread);
     p:=0;
     for x:=0 to idbdata[imagenumber].width-1 do
      for y:=0 to idbdata[imagenumber].height-1 do
      begin
          inc(idbimgpointer);
          if usemem then idbimg[idbimgpointer]:=bit[p];
          if dumpbmp.checked then testbmp32.pixels[x,y]:=gray32(bit[p]);     ////
          inc(p);
      end;
      if dumpbmp.checked then testbmp32.SaveToFile(filepath+'\'+inttostr(time)+'.bmp');  //////
      //

    end;
    if (imagenumber>=maxrec) then
    begin
     showmessage('ERROR:Maxrec reached');
     break;
    end;
  end;
  if dumpbmp.checked then testbmp32.free;
  setlength(bit,0);
  imagefileisopen:=false;
  closefile(idb);
  imgview324.ScrollBars.Increment:=idbheight div 4;
  queryperformancecounter(t2);
  elapsed:=1000*(t2-t1)/freq;
  label98.caption:=inttostr(imagenumber);label98.Update;
 end;
 memo5.Color:=clwhite;
 memo5.Lines.add('DONE');memo5.Update;
 if (label99.caption<>'') and
    (label98.caption<>'') and
    (strtoint(label98.caption)=strtoint(label99.caption)) then rfjchart12click(self);
 imagefileisopen:=true;
 assignfile(idb,idbname);
 reset(idb,1);
 loading_db:=false;
 button80.Caption:='LOAD DB file';
 //Button81Click(Self);
end;

{procedure TForm1.Button81Click(Sender: TObject);
var spec:file;
    indat:array [1..1] of specdata;
    specdat:array [0..0] of specdata;
    bread:integer;
    k,i:integer;
    ymax,testval:integer;
    reclen:integer;
    //global vars, local for now;
    cols,rows:integer;
    size:integer;
    r1,r2,r3:integer;
    testtime:double;
    maxvalue:integer;
    p:integer;
    threshold:double;
    temptime:double;
    efixed:boolean;
    newdata:array of double;
    data:pvector;
    data2:array of smallint;
    tempmean,tempmean2,tempstdev:double;
    tempval:double;
begin
 efixed:=false;
 loading_dat:=true;
 for i:=1 to high(selection) do selection[i]:=true;
 cols:=0;
 rows:=0;

 opendialog2.FileName:=datfile;
 opendialog2.Filter:='DATA Files|*.DAT';
 if opendialog2.Execute then
 begin
  memo1.Clear;
  havesum:=false;
  memo5.Color:=clred;
  memo5.Lines.add('Loading Spectra');memo5.Update;
  imgview324.Bitmap.Clear(clwhite32);
  specdatfile:=opendialog2.filename;
  ///specdatfile:=datfile;
  if specdatfile<>'' then
   begin
    assignfile(spec,specdatfile);
    reset(spec,sizeof(specdata));
    size:=filesize(spec);
    blockread(spec,indat[1],1,bread);
    reclen:=indat[1].data[1]+1;
    testtime:=indat[1].time;
    specreclen:=reclen;
    //setlength(specdat,reclen);
    lcount:=0;
    lcount:=size;
    setlength(kmeans1.iwork,0);
    setlength(kmeans1.iwork,lcount+1);
    setlength(kmeans1.iscore,lcount+1);
    r1:=reclen div 3;
    r2:=2*r1;
    if lcount<maxrec then
    begin
     setlength(dumdata,Lcount+1);
     setlength(dumdata2,Lcount+1);
     seek(spec,0);
     //blockread(spec,indat[1],1,bread);

     //read
     For i:=0 to Lcount-1 do
     begin
       blockread(spec,specdat[0],1,bread);
       dumdata[i].timestamp:=round(specdat[0].Time);

       //check time here
       if not (idbdata[i+1].time=round(specdat[0].Time)) then
       begin
           //error reading time
           closefile(spec);
           showmessage('Error reading Data, Hit OK to try repair....');
           writefixedfiles;
           efixed:=true;
           break;
       end;
       //end check time

       maxvalue:=0;
       threshold:=jvspinedit2.value;
       for k:=3 to reclen do
       begin
          if specdat[0].data[k-2]>maxvalue then maxvalue:=specdat[0].data[k-2];
       end;
       for k:=3 to r1 do
       begin
          dumdata[i].wavform[k-3]:=0;
          if specdat[0].data[k-2]>(threshold*maxvalue) then
             dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
          //dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
       end;
       for k:=r1 to r2 do
       begin
         dumdata[i].wavform[k-3]:=0;
         if specdat[0].data[k-2]>(threshold*maxvalue) then
           dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
         //dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
       end;
       for k:=r2 to reclen do
       begin
         dumdata[i].wavform[k-3]:=0;
         if specdat[0].data[k-2]>(threshold*maxvalue) then
          dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
         //dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
       end;
       for k:=reclen to reclen+200 do
       begin
          //dumdata[i].wavform[k]:=0;
          //dumdata[i].wavform[k]:=10*idbdata[i].width;
          dumdata[i].wavform[k]:=round(5*specdat[0].duration);
       end;
       dumdata[i].wavform[0]:=round(specdat[0].duration);
     end;
     label99.caption:=inttostr(i);label99.Update;
     for i:=0 to trunc(jvspinedit1.value) do
     begin
        dimvector(data,lcount);
        setlength(data2,lcount);
        for k:=0 to Lcount-1 do
        begin
          data[k]:=dumdata[k].wavform[i];
          data2[k]:=dumdata[k].wavform[i];
        end;
        //tempmean:=average(data,0,Lcount-1);
        //form1.caption:=floattostr(tempmean);
        tempmean2:=winsor_average(data2,25);
        tempstdev:=sqrt(variance(data,0,Lcount-1,tempmean2));
        for k:=0 to Lcount-1 do
        begin
          tempval:=0;
          if tempstdev<>0 then
              tempval:=(dumdata[k].wavform[i]-tempmean2)/tempstdev;
          dumdata2[k].wavform[i]:=dumdata[k].wavform[i];
          dumdata[k].wavform[i]:=round(500*tempval);
        end;
        dimvector(data,0);
        setlength(data2,0);
     end;

     cols:=reclen;
     rows:=lcount;
     if not efixed then closefile(spec);
    end;
    if (lcount>=maxrec) then showmessage('ERROR:Maxrec reached');
   end;
  end;
  memo5.Color:=clwhite;
  memo5.Lines.add('DONE');memo5.Update;
 if (label99.caption<>'') and
    (label98.caption<>'') and
    (strtoint(label98.caption)=strtoint(label99.caption)) then rfjchart12click(self);
 loading_dat:=false;
end;
}
procedure TForm1.Button81Click(Sender: TObject);
var spec:file;
    indat:array [1..1] of specdata;
    specdat:array [0..0] of specdata;
    indatf:array [1..1] of specdataf;
    specdatf:array [0..0] of specdataf;
    bread:integer;
    k,i,j:integer;
    ymax,testval:integer;
    reclen:integer;
    //global vars, local for now;
    cols,rows:integer;
    size:integer;
    r1,r2,r3:integer;
    testtime:double;
    maxvalue:integer;
    maxvalueF:double;
    p:integer;
    threshold:double;
    temptime:double;
    efixed:boolean;
    newdata:array of double;
    data:pvector;
    data2:array of smallint;
    dataf:pvector;
    data2f:array of double;
    tempmean,tempmean2,tempstdev:double;
    tempval:double;
    minbin:array[0..20,0..150] of integer;
    plusbin:array[0..20,0..150] of integer;
    bin:integer;
    par:smallint;
    maxval:integer;
    trim:integer;
    binwidth:integer;
    testf:double;
begin
 form32.hide;
 label119.Enabled:=false;
 with form31 do
 begin
    if checkbox98.Checked then form31.show;;
    rfjchart1.Cols:=3;
    rfjchart1.traces:=12;
    for i:=1 to 12 do
    begin
      rfjchart1.trace[i].ygmin:=0;
      rfjchart1.trace[i].ygmax:=100;
      rfjchart1.drawmode:=dmbar;
      rfjchart1.buffered:=true;
      rfjchart1.start:=-1500;
      rfjchart1.eind:=1500;
      rfjchart1.trace[i].yaxislegend:='';
      rfjchart1.trace[i].graphtitle:='Parameter '+inttostr(i-1);
      rfjchart1.trace[i].showtitle:=true;
    end;
    rfjchart1.setuptraces;
    rfjchart1.drawaxes;
    rfjchart1.update;
 end;
 for i:=0 to 11 do for j:=0 to 150 do minbin[i,j]:=0;
 for i:=0 to 11 do for j:=0 to 150 do plusbin[i,j]:=0;
 trim:=trunc(jvspinedit6.value);

 efixed:=false;
 loading_dat:=true;
 for i:=1 to high(selection) do selection[i]:=true;
 cols:=0;
 rows:=0;
 opendialog2.FileName:=dbpath;
 opendialog2.Filter:='FLOAT files|*.DAF|INTEGER files|*.DAT';
 if opendialog2.Execute then
 begin
  memo1.Clear;
  havesum:=false;
  memo5.Color:=clred;
  memo5.Lines.add('Loading Spectra');memo5.Update;
  imgview324.Bitmap.Clear(clwhite32);
  specdatfile:=opendialog2.filename;
  if Uppercase(ExtractFileExt(specdatfile))='.DAF' then Floatdat:=true else Floatdat:=false;
  ///specdatfile:=datfile;
  if (Floatdat=false) and (specdatfile<>'') then
   begin
    assignfile(spec,specdatfile);
    reset(spec,sizeof(specdata));
    size:=filesize(spec);
    blockread(spec,indat[1],1,bread);
    reclen:=indat[1].data[1]+1;
    testtime:=indat[1].time;
    specreclen:=reclen;
    //setlength(specdat,reclen);
    lcount:=0;
    lcount:=size;
    setlength(kmeans1.iwork,0);
    setlength(kmeans1.iwork,lcount+1);
    setlength(kmeans1.iscore,lcount+1);
    r1:=reclen div 3;
    r2:=2*r1;
    if lcount<maxrec then
    begin
     setlength(dumdata,Lcount+1);
     setlength(dumdata2,Lcount+1);
     seek(spec,0);
     //blockread(spec,indat[1],1,bread);

     //read
     For i:=0 to Lcount-1 do
     begin
       blockread(spec,specdat[0],1,bread);
       dumdata[i].timestamp:=round(specdat[0].Time);

       //check time here
       if not (idbdata[i+1].time=round(specdat[0].Time)) then
       begin
           //error reading time
           closefile(spec);
           showmessage('Error reading Data, Hit OK to try repair....');
           writefixedfiles;
           efixed:=true;
           break;
       end;
       //end check time

       //is the width the same?
       //if not (idbdata[i+1].width=(round(specdat[0].Duration)/2)-1) then
       //begin
       //    beep;
       //end;


       maxvalue:=0;
       threshold:=jvspinedit2.value;
       for k:=3 to reclen do
       begin
          if specdat[0].data[k-2]>maxvalue then maxvalue:=specdat[0].data[k-2];
       end;
       for k:=3 to r1 do
       begin
          dumdata[i].wavform[k-3]:=0;
          if specdat[0].data[k-2]>(threshold*maxvalue) then
             dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
          //dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
       end;
       for k:=r1 to r2 do
       begin
         dumdata[i].wavform[k-3]:=0;
         if specdat[0].data[k-2]>(threshold*maxvalue) then
           dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
         //dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
       end;
       for k:=r2 to reclen do
       begin
         dumdata[i].wavform[k-3]:=0;
         if specdat[0].data[k-2]>(threshold*maxvalue) then
          dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
         //dumdata[i].wavform[k-3]:=(specdat[0].data[k-2]);
       end;
       for k:=reclen to reclen+200 do
       begin
          //dumdata[i].wavform[k]:=0;
          //dumdata[i].wavform[k]:=10*idbdata[i].width;
          dumdata[i].wavform[k]:=round(5*specdat[0].duration);
       end;
       dumdata[i].wavform[0]:=round(specdat[0].duration);
     end;
     label99.caption:=inttostr(i);label99.Update;

     for i:=0 to trunc(jvspinedit1.value) do
     begin
        dimvector(data,lcount);
        setlength(data2,lcount);
        binwidth:=50;
        for k:=0 to Lcount-1 do
        begin
          data[k]:=dumdata[k].wavform[i];
          data2[k]:=dumdata[k].wavform[i];
        end;
        if checkbox97.checked then
         begin
          tempmean2:=winsor_average(data2,trim);
          tempstdev:=sqrt(variance(data,0,Lcount-1,tempmean2));
         end
        else
         begin
          tempmean2:=average(data,0,Lcount-1);
          tempstdev:=sqrt(variance(data,0,Lcount-1,tempmean2));
         end;

        for k:=0 to Lcount-1 do
        begin
          tempval:=0;
          if tempstdev<>0 then
              tempval:=(dumdata[k].wavform[i]-tempmean2)/tempstdev;
          dumdata2[k].wavform[i]:=dumdata[k].wavform[i];
          dumdata[k].wavform[i]:=round(500*tempval);
          bin:=dumdata[k].wavform[i] div 50;
          if (bin>0) and (bin<150) then inc(plusbin[i,bin]);
          if (bin<0) and (abs(bin)<150) then inc(minbin[i,-bin]);
        end;
        dimvector(data,0);
        setlength(data2,0);
     end;

     with form31 do
     begin
       for i:=0 to 11 do
       begin
        maxval:=1;
        for j:=1 to 150 do
        begin
          if minbin[i,j]>maxval then maxval:=minbin[i,j];
          if plusbin[i,j]>maxval then maxval:=plusbin[i,j];
        end;
        maxval:=round(maxval*1.15);
        rfjchart1.addstart(i+1,150*binwidth,100*par/maxval);
        for j:=150 downto 1 do
        begin
          par:=minbin[i,j];
          //if par >0 then
          rfjchart1.addpoint(i+1,(-j+1)*binwidth,100*par/maxval);
        end;
        rfjchart1.addstart(i+1,0*binwidth,100*par/maxval);
        for j:=1 to 150 do
        begin
          par:=plusbin[i,j];
          //if par >0 then
          rfjchart1.addpoint(i+1,j*binwidth,100*par/maxval);
        end;
       end;
       if checkbox98.Checked then rfjchart1.update;
     end;

     cols:=reclen;
     rows:=lcount;
     if not efixed then closefile(spec);
    end;
    if (lcount>=maxrec) then showmessage('ERROR:Maxrec reached');
   end;


  if (Floatdat=True) and (specdatfile<>'') then
   begin
    form32.show;
    assignfile(specf,specdatfile);
    reset(specf,sizeof(specdataf));
    size:=filesize(specf);
    blockread(specf,indatf[1],1,bread);
    reclen:=trunc(indatf[1].data[1]+1);
    testtime:=indatf[1].time;
    specreclen:=reclen;
    //setlength(specdat,reclen);
    lcount:=0;
    lcount:=size;
    setlength(kmeans1F.iwork,0);
    setlength(kmeans1F.iwork,lcount+1);
    setlength(kmeans1F.iscore,lcount+1);
    r1:=reclen div 3;
    r2:=2*r1;
    if lcount<maxrec then
    begin
     setlength(dumdataf,Lcount+1);
     setlength(dumdata2f,Lcount+1);
     seek(specf,0);
     //blockread(spec,indat[1],1,bread);

     //read
     For i:=0 to Lcount-1 do
     begin
       blockread(specf,specdatf[0],1,bread);
       dumdataf[i].timestamp:=(specdatf[0].Time);

       //check time here
       if not (idbdata[i+1].time=round(specdatf[0].Time)) then
       begin
           //error reading time
           closefile(specf);
           showmessage('Error reading Data, Unequal file lenghts of DB/DAF files');
           //writefixedfiles;
           efixed:=true;
           break;
       end;
       //end check time

       //is the width the same?
       //if not (idbdata[i+1].width=(round(specdat[0].Duration)/2)-1) then
       //begin
       //    beep;
       //end;


       maxvalueF:=0;
       threshold:=jvspinedit2.value;
       for k:=3 to 20 do
       begin
          testF:=specdatf[0].data[k-2] ;
          if Testf>maxvalueF then maxvalueF:=TestF;
       end;
       for k:=3 to 20 do
       begin
          dumdataf[i].wavformf[k-3]:=0;
          if specdatf[0].data[k-2]>(threshold*maxvalueF) then
             dumdataf[i].wavformf[k-3]:=(specdatf[0].data[k-2]);
       end;
       dumdataf[i].wavformf[0]:=(specdatf[0].duration);
     end;
     label99.caption:=inttostr(i);label99.Update;

     for i:=0 to trunc(jvspinedit1.value) do
     begin
        dimvector(dataf,lcount);
        setlength(data2f,lcount);
        binwidth:=50;
        for k:=0 to Lcount-1 do
        begin
          dataf[k]:=dumdataf[k].wavformf[i];
          data2f[k]:=dumdataf[k].wavformf[i];
        end;
        if checkbox97.checked then
         begin
          tempmean2:=winsor_averagef(data2f,trim);
          tempstdev:=sqrt(variance(dataf,0,Lcount-1,tempmean2));
         end
        else
         begin
          tempmean2:=average(dataf,0,Lcount-1);
          tempstdev:=sqrt(variance(dataf,0,Lcount-1,tempmean2));
         end;

        for k:=0 to Lcount-1 do
        begin
          tempval:=0;
          if tempstdev<>0 then tempval:=(dumdataf[k].wavformf[i]-tempmean2)/tempstdev;
          dumdata2f[k].wavformf[i]:=dumdataf[k].wavformf[i];
          dumdataf[k].wavformf[i]:=500*tempval;
          bin:=trunc(dumdataf[k].wavformf[i]/50);
          if (bin>0) and (bin<150) then inc(plusbin[i,bin]);
          if (bin<0) and (abs(bin)<150) then inc(minbin[i,-bin]);
        end;
        dimvector(dataf,0);
        setlength(data2f,0);
     end;

     with form31 do
     begin
       for i:=0 to 11 do
       begin
        maxval:=1;
        for j:=1 to 150 do
        begin
          if minbin[i,j]>maxval then maxval:=minbin[i,j];
          if plusbin[i,j]>maxval then maxval:=plusbin[i,j];
        end;
        maxval:=round(maxval*1.15);
        //par:=minbin[i,j];
        rfjchart1.addstart(i+1,150*binwidth,100*par/maxval);
        for j:=150 downto 1 do
        begin
          par:=minbin[i,j];
          //if par >0 then
          rfjchart1.addpoint(i+1,(-j+1)*binwidth,100*par/maxval);
        end;
        rfjchart1.addstart(i+1,0*binwidth,100*par/maxval);
        for j:=1 to 150 do
        begin
          par:=plusbin[i,j];
          //if par >0 then
          rfjchart1.addpoint(i+1,j*binwidth,100*par/maxval);
        end;
       end;
       if checkbox98.Checked then rfjchart1.update;
     end;

     cols:=reclen;
     rows:=lcount;
     if not efixed then closefile(specf);
    end;
    if (lcount>=maxrec) then showmessage('ERROR:Maxrec reached');
   end;
  end;
  memo5.Color:=clwhite;
  memo5.Lines.add('DONE');memo5.Update;
 if (label99.caption<>'') and
    (label98.caption<>'') and
    (strtoint(label98.caption)=strtoint(label99.caption)) then rfjchart12click(self);
 loading_dat:=false;
end;


procedure TForm1.RxSpinEdit60Change(Sender: TObject);
var i:integer;
    sp:integer;
   //
    specrec:array [1..1] of specdata;
    specrecF:array [1..1] of specdataF;
    filename:string;
    start,eind:double;
    clip:wavefile;
    written:integer;
    result:boolean;
    timestring:string;
    whrs,wmin,wsec,secinday,msecinday:integer;
    rec,playcluster,x1,x2,y1,y2:integer;
    wbuffer:array[1..441] of smallint;
    checkstate:boolean;
begin
 //before the threads starts
 InitializeCriticalSection(CriticalSection);

 if not (loading_db or loading_dat) then
 begin
  image321.Bitmap.SetSize(100,100);
  image321.bitmap.Clear(clwhite32);

  if usedisk then readimagebyindex(trunc(rxspinedit60.value));
  if usemem then memreadimagebyindex(trunc(rxspinedit60.value));

  if form24.CheckBox2.checked then for i:=1 to 441 do wbuffer[i]:=0;

  if checkbox91.Checked then
  begin
   checkstate:=checkbox53.Checked;
   checkbox53.Checked:=false; //force daytime reading

   if not floatdat then
   begin
     assignfile(spec,specdatfile);
     reset(spec,sizeof(specdata));
     seek(spec,trunc(rxspinedit60.value)-1);
     blockread(spec,specrec[1],1);
     closefile(spec);
     opendialog1.filename:=specrec[1].Filename;
     timestring:=z_ItemCGetFmTo(specrec[1].Filename,1,1,'_');
   end;
   if floatdat then
   begin
     assignfile(specf,specdatfile);
     reset(specf,sizeof(specdataf));
     seek(specf,trunc(rxspinedit60.value)-1);
     blockread(specf,specrecf[1],1);
     closefile(specf);
     opendialog1.filename:=specrecf[1].Filename;
     timestring:=z_ItemCGetFmTo(specrecF[1].Filename,1,1,'_');
   end;


   Hrs:=z_SMiddle(Timestring,1,2);
   Min:=z_SMiddle(Timestring,3,2);
   Sec:=z_SMiddle(Timestring,5,2);
   whrs:=strtoint(hrs);
   wmin:=strtoint(min);
   wsec:=strtoint(sec);
   secinday:=(3600*whrs)+(60*wmin)+wsec;
   msecinday:=1000*secinday;

   If not FileExists(opendialog1.filename) then
         ShowMessage('FILE NOT FOUND ('+opendialog1.filename+')')
   else
   begin
    showwave;
    fileread:=false;
    if not floatdat then
    begin
      start:=specrec[1].Time-msecinday;
      eind:=start+specrec[1].Duration;
    end;
    if floatdat then
    begin
      start:=specrecF[1].Time-msecinday;
      eind:=start+specrecF[1].Duration;
    end;
    Eindsample:=trunc(eind*rate/1000);
    Startsample:=trunc(start*rate/1000);
    checkbox53.Checked:=checkstate; //reset this

    //if not DirectoryExists('c:\temp\') then
    //        if not CreateDir('c:\temp\') then
    //             raise Exception.Create('Cannot create '+'c:\temp\');

    //in the thread
    EnterCriticalSection(CriticalSection);

    result:=false;
    //if DirectoryExists('c:\temp\') then
    begin
     clip:=wavefile.create;
     clip.Init;
     clip.openforwrite('$$$.wav',rate,16,1,result);
     if result then clip.WriteSampledata((eindsample-startsample),written,wavdata[startsample]);
     if (written<>(eindsample-startsample)) then result:=false;
     clip.Close;
     clip.free;
    end;
    if result then
    begin
     //play only if we are not collacting the syllables into a file then
     if not form24.CheckBox2.checked then
     begin
      jvwaveplayer1.Asynchronous:=true;
      if fileexists('$$$.wav') then
      begin
        jvwaveplayer1.FileName:='$$$.wav';
        jvwaveplayer1.Play;
        imgview324.bitmap.Assign(showbmp[trunc(rxspinedit71.value)]);
        imgview324.Update;
      end;
     end;
     end;
     if form24.CheckBox2.checked then
     begin
      sumwav.WriteSampleData(441,written,wbuffer[1]);
      sumwav.WriteSampleData(eindsample-startsample,written,wavdata[startsample]);
      sumwav.WriteSampleData(441,written,wbuffer[1]);
     end;
   end;
   //End of safe block
   LeaveCriticalSection(CriticalSection);
  end;

  //if checkbox83.Checked then image321.Bitmap.assign(idbimage[trunc(rxspinedit60.value)]);
  if checkbox83.Checked then
  begin
    image321.Bitmap.assign(idbbmp);
    image321.Update;
    image321.canvas.Textout(1,1,floattostr(round(idbdata[trunc(rxspinedit60.value)].time)));
    if not floatdat then
        image321.canvas.Textout(1,20,inttostr(kmeans1.iscore[trunc(rxspinedit60.value-1)] div 1000));
    if floatdat then
        image321.canvas.Textout(1,20,inttostr(kmeans1F.iscore[trunc(rxspinedit60.value-1)] div 1000));
  end;
  label90.caption:=inttostr(idbdata[trunc(rxspinedit60.value)].width);
  //
  //show spectrum of current image
  if checkbox83.Checked then
  begin
      form28.show;
      if form28.Panel2.visible then form28.memo1.Clear;
      form28.rfjchart1.traces:=1;
      form28.rfjChart1.trace[1].ygmin:=0;
      form28.rfjChart1.trace[1].ygmax:=form28.ScrollBar1.max-form28.ScrollBar1.position;
      if checkbox92.checked then
      begin
        form28.rfjChart1.trace[1].ygmin:=-1500;
        form28.rfjChart1.trace[1].ygmax:=1500;
      end;
      form28.rfjchart1.start:=0;
      //form28.rfjChart1.eind:=specreclen+trunc(rxspinedit75.Value)-1;
      if not floatdat then form28.rfjChart1.eind:=kmeans1.lastdatpt;
      if floatdat then form28.rfjChart1.eind:=kmeans1F.lastdatpt;
      form28.rfjchart1.drawmode:=dmline;
      form28.rfjchart1.setuptraces;
      form28.rfjchart1.drawaxes;
      sp:=trunc(rxspinedit60.value-1);

      if not floatdat then
               form28.rfjchart1.addstart(1,kmeans1.firstdatpt,dumdata[sp].wavform[kmeans1.firstdatpt]);
      if floatdat then
               form28.rfjchart1.addstart(1,kmeans1F.firstdatpt,dumdataF[sp].wavformF[kmeans1F.firstdatpt]);

      if not floatdat then
      begin
       if form28.Panel2.visible then
        for i:=(kmeans1.firstdatpt) to trunc(form28.rfjChart1.eind) do
        begin
          form28.rfjchart1.addpoint(1,i,dumdata[sp].wavform[i]);
          form28.Memo1.lines.add(inttostr(dumdata[sp].wavform[i]));
        end
       else
        for i:=(kmeans1.firstdatpt) to trunc(form28.rfjChart1.eind) do
        begin
          form28.rfjchart1.addpoint(1,i,dumdata[sp].wavform[i]);
        end;
      end;

      if floatdat then
      begin
       if form28.Panel2.visible then
        for i:=(kmeans1F.firstdatpt) to trunc(form28.rfjChart1.eind) do
        begin
          form28.rfjchart1.addpoint(1,i,dumdataF[sp].wavformF[i]);
          form28.Memo1.lines.add(floattostr(dumdataF[sp].wavformF[i]));
        end
       else
        for i:=(kmeans1F.firstdatpt) to trunc(form28.rfjChart1.eind) do
        begin
          form28.rfjchart1.addpoint(1,i,dumdataF[sp].wavformF[i]);
        end;
      end;
      //form28.rfjChart1.autoscale(1);
      form28.rfjchart1.update;
  end;
  //
  if not movie then
  begin
   rfjchart12.keepdata:=true;
   rfjchart12.setuptraces;
   rfjchart12.drawaxes;
   rfjchart12.drawbuffer(1);
   rfjchart12.setxmark(1,idbdata[trunc(rxspinedit60.value)].width+2);
   rfjchart12.update;
  end;
  //
 end;
end;

procedure Tform1.readimage(imagetime:integer);
var i,x,y:integer;
    bytesread:integer;
    pixel:integer;
    time:integer;
    bit:array of byte;
    p:integer;
    found:boolean;
begin
  assignfile(idb,idbname);
  imagefileisopen:=true;  
  reset(idb,1);
  //found:=false;
    for i:=1 to idbsize do
    begin
     if (idbdata[i].time=imagetime) then
     begin
      setlength(bit,idbdata[i].width*idbdata[i].height);
      idbbmp.setsize(idbdata[i].width,idbdata[i].height);//variable width
      //idbbmp.Clear(clwhite32);
      seek(idb,idbdata[i].offset+8);
      blockread(idb,bit[0],(idbdata[i].width*idbdata[i].height),bytesread);
      p:=0;
      for x:=0 to idbdata[i].width-1 do
       for y:=0 to idbdata[i].height-1 do
       begin
          idbbmp.Pixel[x,y]:=gray32(bit[p]);
          inc(p);
       end;
       //found:=true;
       break;
     end;
    end;
  imagefileisopen:=false;
  closefile(idb);
  setlength(bit,0);
end;

procedure Tform1.readimagebyindex(index:integer);
var i,x,y:integer;
    bytesread:integer;
    pixel:integer;
    time:integer;
    bit:array of byte;
    p:integer;
    found:boolean;
begin
  i:=index;
  setlength(bit,idbdata[i].width*idbdata[i].height);
  idbbmp.setsize(idbdata[i].width,idbdata[i].height);//variable width
  seek(idb,idbdata[i].offset+8);
  blockread(idb,bit[0],((idbdata[i].width)*(idbdata[i].height)),bytesread);
  p:=0;
  for x:=0 to idbdata[i].width-1 do
    for y:=0 to idbdata[i].height-1 do
       begin
          idbbmp.Pixel[x,y]:=greyscale[bit[p]];
          inc(p);
       end;
  //setlength(bit,0);
end;

procedure Tform1.memreadimagebyindex(index:integer);
var i,x,y:integer;
    bytesread:integer;
    pixel:integer;
    time:integer;
    //bit:array of byte;
    p:integer;
    found:boolean;
begin
  i:=index;
  idbbmp.setsize(idbdata[i].width,idbdata[i].height);//variable width
  p:=idbdata[i].offset+2;
  for x:=0 to idbdata[i].width-1 do
    for y:=0 to idbdata[i].height-1 do
       begin
          idbbmp.Pixel[x,y]:=greyscale[idbimg[p]];
          inc(p);
       end;
  //let op: deze bitmaps hebben niet genoeg resolutie om de tijd aan te geven
  //idbbmp.Textout(1,1,inttostr(idbdata[i].time));
end;

procedure Tform1.readsmallimagebyindex(index:integer);
var i,x,y:integer;
    bytesread:integer;
    pixel:integer;
    time:integer;
    bit:array of byte;
    p:integer;
    found:boolean;
    w,h:integer;
begin
  i:=index;
  w:=idbdata[i].width div 2;
  h:=idbdata[i].height div 2;
  setlength(bit,w*h);
  idbbmp.setsize(w,h);//variable width
  seek(idb,idbdata[i].offset+8);
  blockread(idb,bit[0],(w*h),bytesread);
  p:=0;
  for x:=0 to w-1 do
    for y:=0 to h-1 do
       begin
          //idbbmp.Pixel[x,y]:=gray32(bit[p]);
          idbbmp.Pixel[x,y]:=greyscale[bit[p]];
          inc(p,2);
       end;
  //setlength(bit,0);
end;

procedure Tform1.readidbbyindex(index:integer);
var i,x,y:integer;
    bytesread:integer;
    pixel:integer;
    time:integer;
    p:integer;
    found:boolean;
begin
  i:=index;
  setlength(bit,idbdata[i].width*idbdata[i].height);
  seek(idb,idbdata[i].offset+8);
  blockread(idb,bit[0],(idbdata[i].width*idbdata[i].height),bytesread);
end;

procedure Tform1.memreadidbbyindex(index:integer);
var i,x,y:integer;
    bytesread:integer;
    pixel:integer;
    time:integer;
    p:integer;
    found:boolean;
begin
  i:=index;
  setlength(bit,idbdata[i].width*idbdata[i].height);
  seek(idb,idbdata[i].offset+8);
  blockread(idb,bit[0],(idbdata[i].width*idbdata[i].height),bytesread);
end;

procedure Tform1.readidb(imagetime:integer);
var i,x,y:integer;
    bytesread:integer;
    pixel:integer;
    time:integer;
    p:integer;
    found:boolean;
begin
  assignfile(idb,idbname);
  reset(idb,1);
  for i:=1 to idbsize-2 do
    begin
     if (idbdata[i].time=imagetime) then
     begin
      setlength(bit,idbdata[i].width*idbdata[i].height);
      seek(idb,idbdata[i].offset+8);
      blockread(idb,bit[0],(idbdata[i].width*idbdata[i].height),bytesread);
      break;
     end;
  end;
  imagefileisopen:=false;
  closefile(idb);
  //setlength(bit,0);
end;

//procedure Tform1.showbin(bin:integer);
//var
//begin
//
//end;

procedure TForm1.rfjChart12click(Sender: TObject);
var i,width:integer;
    bin:integer;
    //global vars: local for now
    cbmp:Tbitmap32;
    cx,cy:integer;
    spec:file;
    counter1:integer;
    specrec:array [1..1] of specdata;
    filename,lastname:string;
    upper,lower:integer;
    maxy:integer;
    rowsneeded:integer;
    heightneeded:integer;
    clusterwidth:array[0..99] of integer;
    xmax:integer;
    plotdata:array of smallint;
begin
   memo5.Color:=clred;
   Memo5.Lines.add('Creating Histogram');Memo5.update;
   assignfile(spec,specdatfile);
   if not Floatdat then reset(spec,sizeof(specdata));
   if Floatdat then  reset(spec,sizeof(specdataf));

   xmax:=trunc(rxspinedit64.Value);
   for i:=1 to xmax do idbbinhis[i]:=0;
   rfjchart12.traces:=1;
   rfjchart12.buffered:=true;
   rfjchart12.eind:=xmax;
   rfjchart12.trace[1].ygmin:=0;
   rfjchart12.drawmode:=dmskyline;
   rfjchart12.setuptraces;

   setlength(plotdata,lcount);
   for i:=1 to lcount do
   begin
       plotdata[i]:=idbdata[i].width;
       //plotdata[i]:=50+round(dumdata[i].wavform[scrollbar7.Position]/50);
   end;

   for i:=1 to lcount do
   begin
       width:=plotdata[i];
       bin:=1+(width div 1);
       if bin<high(idbbinhis) then inc(idbbinhis[bin]);
   end;

   lower:= trunc(rxspinedit61.Value);
   upper:= trunc(rxspinedit62.Value);
   if (upper=lower) and (label89.caption<>'') then
   begin
     upper:=strtoint(label89.caption)+1;
     lower:=strtoint(label89.caption)-1;
   end;


   totalwidth:=0;
   for i:=1 to lcount do
   begin
       if (idbdata[i].width>lower) and (idbdata[i].width<upper) then
                        totalwidth:=totalwidth+idbdata[i].width+5;
   end;
   rowsneeded:=2+(totalwidth div imgview324.width) div 2;
   heightneeded:=trunc(0.55*rowsneeded*((idbdata[1].height)+5));
   if heightneeded<1000 then heightneeded:=1000;

   maxy:=0;
   for i:=1 to xmax do
   begin
      if idbbinhis[i]>maxy then maxy:=idbbinhis[i];
   end;
   rfjchart12.buffered:=true;
   rfjchart12.traces:=1;
   rfjchart12.trace[1].buffersize:=0;//reset buffer;
   rfjchart12.trace[1].memsize:=2000;
   rfjchart12.eind:=xmax;
   rfjchart12.trace[1].ygmin:=0;
   rfjchart12.trace[1].ygmax:=round(maxy*1.10);
   rfjchart12.drawmode:=dmskyline;
   rfjchart12.setuptraces;
   rfjchart12.drawaxes;
   rfjchart12.addstart(1,0,0);
   for i:=1 to xmax do
   begin
      rfjchart12.addpoint(1,i,idbbinhis[i]);
   end;
   //rfjchart12.autoscale(1);
   rfjchart12.update;
   application.ProcessMessages;

   form23.Memo1.clear;
   if checkbox81.Checked then for i:=1 to high(selection) do selection[i]:=false;
   if checkbox81.Checked then
   begin
    //make bitmap
    memo5.Color:=clred;
    Memo5.Lines.add('Creating Bitmap');Memo5.update;
    cbmp:=Tbitmap32.create;
    cbmp.SetSize(imgview324.Width,heightneeded);
    cbmp.Clear(clwhite32);
    cx:=2;cy:=2;
    lower:= trunc(rxspinedit61.Value);
    upper:= trunc(rxspinedit62.Value);
    if (upper=lower) and (label89.caption<>'') then
    begin
     upper:=strtoint(label89.caption)+1;
     lower:=strtoint(label89.caption)-1;
    end;
    Memo5.Lines.add('Getting Images');Memo5.update;

    //cluster:=0;
    rxspinedit71.Value:=0;
    for i:=1 to lcount do
    begin
       width:=idbdata[i].width;
       if (width>lower) and (width<upper) then
       begin
         selection[i]:=true;
         if usedisk then readimagebyindex(i);
         if usemem then memreadimagebyindex(i);
         if cy<cbmp.Height then
         begin
            cbmp.Draw(rect(cx,cy,cx+idbbmp.Width div 2 ,cy+idbbmp.height div 2),
                            rect(0,0,idbbmp.Width,idbbmp.height),
                            idbbmp);

           cx:=cx+idbbmp.Width div 2+2;
           if (cx+idbbmp.Width)>cbmp.Width then
           begin
              cx:=2;
              cy:=cy+idbbmp.height div 2+2;
           end;
           //
           {
           inc(areacounter[cluster]);
           area[cluster,areacounter[cluster]].topleft.X:=scx[j];
           area[cluster,areacounter[cluster]].topleft.y:=scy[j];
           area[cluster,areacounter[cluster]].bottomright.x:=scx[j]+idbbmp.Width div 2;
           area[cluster,areacounter[cluster]].bottomright.y:=scy[j]+idbbmp.height div 2;
           area[cluster,areacounter[cluster]].cluster:=j;
           area[cluster,areacounter[cluster]].item:=bmppointer;
           areatrack[bmppointer]:=areacounter[cluster]; //reverse lookup;
           }
           //
           seek(spec,i-1);
           blockread(spec,specrec[1],1);
           filename:=specrec[1].Filename;
           if filename<>lastname then
           begin
           //     form23.memo1.lines.add('*********************************');
                counter1:=0;
           end;
           lastname:=filename;
           inc(counter1);
           //form23.memo1.lines.add(inttostr(counter1)+' '+filename+'  ,'+floattostr(specrec[1].Time));
           //
         end;
       end;
    end;
    Memo5.Lines.add('Showing Bitmap');Memo5.update;
    imgview324.bitmap.Assign(cbmp);
   end;
   if checkbox82.Checked then
   begin
    //make bitmap
    Memo5.Lines.add('Creating Bitmap');Memo5.update;
    cbmp:=Tbitmap32.create;
    cbmp.SetSize(imgview324.Width,heightneeded);
    cbmp.Clear(clwhite32);
    cx:=2;cy:=2;
    for i:=1 to lcount do
    begin
       width:=idbdata[i].width;
       if (width>lower) and (width<upper) then
       begin
         selection[i]:=true;
         rxspinedit60.value:=i; //shows image and triggers update
         application.ProcessMessages;
         if cy<cbmp.Height then
         begin
           cbmp.Draw(
                     rect(cx,cy,cx+(idbimage[i].Width div 2) ,cy+(idbimage[i].height div 2)),
                     rect(0,0,idbimage[i].Width,idbimage[i].height),
                     idbimage[i]
                     );

           cx:=cx+idbimage[i].Width div 2+2;
           if (cx+idbimage[i].Width)>cbmp.Width then
           begin
              cx:=0;
              cy:=cy+idbimage[i].height div 2+2;
           end;
           //
           seek(spec,i-1);
           blockread(spec,specrec[1],1);
           filename:=specrec[1].Filename;
           if filename<>lastname then
           begin
           //     form23.memo1.lines.add('*********************************');
                counter1:=0;
           end;
           lastname:=filename;
           inc(counter1);
           //form23.memo1.lines.add(inttostr(counter1)+' '+filename+'  ,'+floattostr(specrec[1].Time));
           //
         end;
       end;
    end;
    Memo5.Lines.add('Showing Bitmap');Memo5.update;
    imgview324.bitmap.Assign(cbmp);
    //form23.Show;
    cbmp.free;
   end;
   closefile(spec);
   memo5.Color:=clwhite;
   Memo5.lines.add('DONE');Memo5.Update;
end;


procedure TForm1.RxSpinEdit63Change(Sender: TObject);
begin
   imgview324.Scale:=rxspinedit63.value;
end;

procedure TForm1.rfjChart12MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer; Layer: TCustomLayer);
begin
    label89.Caption:=inttostr(trunc(rfjchart12.xpos2val(x,y)-1));
end;

function Tform1.calcspecdist(k,l:integer):extended;
var i,j:integer;
    dif:double;
    data1,data2:array[0..999] of double;
    pts:integer;
begin
    zeromemory(@data1,1000);
    zeromemory(@data2,1000);
    pts:=specreclen;
    for i:=3 to pts do
    begin
         data1[i]:=dumdata[k].wavform[i];
         data2[i]:=dumdata[l].wavform[i]
    end;
    result:=SqrDistance(@data1[0],@data2[0],pts-1)/pts;
end;



procedure TForm1.Button82Click(Sender: TObject);
begin
   imagefileisopen:=false;
   closefile(idb);
   closefile(spec);
end;

procedure TForm1.Button83Click(Sender: TObject);
var idb_selection:file;
    spec_selection,spec:file;
    pixelvalarray:array of byte;
    bwritten,bread:integer;
    i,x,y,pixelpointer:integer;
    specdat:array [1..1] of specdata;
    specdatF:array [1..1] of specdataF;
    firstrec:boolean;
    selected:integer;
    p:integer;
begin
 if not floatdat then
 begin
  imageselectionfile:=filepath+'\'+'images_selection'+inttostr(trunc(rxspinedit70.value))+'.db';
  assignfile(idb_selection,imageselectionfile);
  rewrite(idb_selection,1);
  idb_written:=0;
  specselectionfile:=filepath+'\'+'spectra_selection'+inttostr(trunc(rxspinedit70.value))+'.dat';
  assignfile(spec_selection,specselectionfile);
  rewrite(spec_selection, sizeof(specdata));
  assignfile(spec,specdatfile);
  reset(spec,sizeof(specdata));
  firstrec:=false;
  memo5.Color:=clred;
  memo5.Lines.add('Saving Selection');Memo5.Update;
  selected:=0;
  for i:=1 to lcount do
  begin
     if selection[i] and (kmeans1.iwork[i-1]<(numclusters+1)) then
     begin
         //images
         //readidb(idbdata[i].time);  //reads to idbbmp
         inc(selected);
         //rxspinedit60.value:=i;
         blockwrite(idb_selection,idbdata[i].time,4,bwritten);
         blockwrite(idb_selection,idbdata[i].width,2,bwritten);
         blockwrite(idb_selection,idbdata[i].height,2,bwritten);
         p:=idbdata[i].offset+2;
         blockwrite(idb_selection,idbimg[p],(idbdata[i].width*idbdata[i].height),bwritten);

         //spectra
         seek(spec,i-1);
         blockread(spec,specdat[1],1,bread);
         if not firstrec then specdat[1].Data[1]:=specreclen-1;
         firstrec:=true;
         blockwrite(spec_selection,specdat[1],1,bwritten);
     end;
  end;
  label97.caption:=inttostr(selected);label97.Update;
  closefile(idb_selection);
  closefile(spec_selection);
  memo5.Color:=clwhite;
  memo5.Lines.add('DONE');memo5.Update;
 end;

 if floatdat then
 begin
  imageselectionfile:=filepath+'\'+'images_selection'+inttostr(trunc(rxspinedit70.value))+'.db';
  assignfile(idb_selection,imageselectionfile);
  rewrite(idb_selection,1);
  idb_written:=0;
  specselectionfile:=filepath+'\'+'spectra_selection'+inttostr(trunc(rxspinedit70.value))+'.daf';
  assignfile(spec_selection,specselectionfile);
  rewrite(spec_selection, sizeof(specdataF));
  assignfile(spec,specdatfile);
  reset(spec,sizeof(specdataF));
  firstrec:=false;
  memo5.Color:=clred;
  memo5.Lines.add('Saving Selection');Memo5.Update;
  selected:=0;
  for i:=1 to lcount do
  begin
     if selection[i] and (kmeans1F.iwork[i-1]<(numclusters+1)) then
     begin
         //images
         //readidb(idbdata[i].time);  //reads to idbbmp
         inc(selected);
         //rxspinedit60.value:=i;
         blockwrite(idb_selection,idbdata[i].time,4,bwritten);
         blockwrite(idb_selection,idbdata[i].width,2,bwritten);
         blockwrite(idb_selection,idbdata[i].height,2,bwritten);
         p:=idbdata[i].offset+2;
         blockwrite(idb_selection,idbimg[p],(idbdata[i].width*idbdata[i].height),bwritten);

         //spectra
         seek(spec,i-1);
         blockread(spec,specdatF[1],1,bread);
         if not firstrec then specdatF[1].Data[1]:=specreclen-1;
         firstrec:=true;
         blockwrite(spec_selection,specdatF[1],1,bwritten);
     end;
  end;
  label97.caption:=inttostr(selected);label97.Update;
  closefile(idb_selection);
  closefile(spec_selection);
  memo5.Color:=clwhite;
  memo5.Lines.add('DONE');memo5.Update;
 end;

end;

procedure Tform1.writefixedfiles;
var idb_selection:file;
    spec_selection,spec:file;
    pixelvalarray:array of byte;
    bwritten,bread:integer;
    i,x,y,pixelpointer:integer;
    specdat:array [1..1] of specdata;
    specdatF:array [1..1] of specdataF;
    firstrec:boolean;
    selected:integer;
    p,k:integer;
    ip,offset:integer;
begin
 if not floatdat then
 begin
  imageselectionfile:=filepath+'\'+'images_repair.db';
  assignfile(idb_selection,imageselectionfile);
  rewrite(idb_selection,1);
  idb_written:=0;
  specselectionfile:=filepath+'\'+'spectra_repair.dat';
  assignfile(spec_selection,specselectionfile);
  rewrite(spec_selection, sizeof(specdata));
  assignfile(spec,specdatfile);
  reset(spec,sizeof(specdata));
  firstrec:=false;
  memo5.Color:=clred;
  memo5.Lines.add('REPAIRING FILES');Memo5.Update;
  selected:=0;
  offset:=0;
  for i:=1 to lcount do
  begin
     //if selection[i] and (kmeans1.iwork[i-1]<(numclusters+1)) then
     begin
         //spectra
         seek(spec,i-1);
         blockread(spec,specdat[1],1,bread);
         while not (idbdata[i+offset].time=round(specdat[1].Time)) do
         begin
           inc(offset);
         end;

         //images
         inc(selected);
         ip:=i+offset;
         blockwrite(idb_selection,idbdata[ip].time,4,bwritten);
         blockwrite(idb_selection,idbdata[ip].width,2,bwritten);
         blockwrite(idb_selection,idbdata[ip].height,2,bwritten);
         p:=idbdata[ip].offset+2;
         blockwrite(idb_selection,idbimg[p],(idbdata[ip].width*idbdata[ip].height),bwritten);

         if not firstrec then specdat[1].Data[1]:=specreclen-1; firstrec:=true;

         blockwrite(spec_selection,specdat[1],1,bwritten);
     end;
  end;
  label97.caption:=inttostr(selected);label97.Update;
  closefile(idb_selection);
  closefile(spec_selection);
  memo5.Color:=clwhite;
  memo5.Lines.add('DONE');memo5.Update;
  showmessage('Data written to images_repair.db and spectra_repair.dat');
 end;

 if floatdat then
 begin
  imageselectionfile:=filepath+'\'+'images_repair.db';
  assignfile(idb_selection,imageselectionfile);
  rewrite(idb_selection,1);
  idb_written:=0;
  specselectionfile:=filepath+'\'+'spectra_repair.daf';
  assignfile(spec_selection,specselectionfile);
  rewrite(spec_selection, sizeof(specdataF));
  assignfile(spec,specdatfile);
  reset(spec,sizeof(specdataF));
  firstrec:=false;
  memo5.Color:=clred;
  memo5.Lines.add('REPAIRING FILES');Memo5.Update;
  selected:=0;
  offset:=0;
  for i:=1 to lcount do
  begin
     //if selection[i] and (kmeans1.iwork[i-1]<(numclusters+1)) then
     begin
         //spectra
         seek(spec,i-1);
         blockread(spec,specdatF[1],1,bread);
         while not (idbdata[i+offset].time=round(specdatF[1].Time)) do
         begin
           inc(offset);
         end;

         //images
         inc(selected);
         ip:=i+offset;
         blockwrite(idb_selection,idbdata[ip].time,4,bwritten);
         blockwrite(idb_selection,idbdata[ip].width,2,bwritten);
         blockwrite(idb_selection,idbdata[ip].height,2,bwritten);
         p:=idbdata[ip].offset+2;
         blockwrite(idb_selection,idbimg[p],(idbdata[ip].width*idbdata[ip].height),bwritten);

         if not firstrec then specdat[1].Data[1]:=specreclen-1; firstrec:=true;

         blockwrite(spec_selection,specdatF[1],1,bwritten);
     end;
  end;
  label97.caption:=inttostr(selected);label97.Update;
  closefile(idb_selection);
  closefile(spec_selection);
  memo5.Color:=clwhite;
  memo5.Lines.add('DONE');memo5.Update;
  showmessage('Data written to images_repair.db and spectra_repair.dat');
 end;

end;


procedure TForm1.Button84Click(Sender: TObject);
var i,j,k:integer;
    wp:integer;
    it:integer;
    noise:integer;
    pts,l:integer;
    st:string;
    c1,c2:integer;
    orphans:integer;
    t2,t1,freq:int64;
    elapsed:double;
    pstat:double;
    ymax,testval:double;
    tw,tw1,tw2:integer;
    teststring:string;
    wav:waveform;
    wavf:waveformf;
    sumtime:double;
    sumtimecount:integer;
    test:smallint;
    indat:array [1..1] of specdata;
    specdat:array of specdata;
    indatF:array [1..1] of specdataF;
    specdatF:array of specdataF;
    bread:integer;
    spec:file;
    reclen:integer;
    totaltime:double;
    cfreq:int64;
    maxloc:integer;
    totalpoints:integer;
    setclusters:integer;
    realclusters,realcount,testcount,target:integer;
    maxit:integer;
    widthweight:integer;
begin
 rxspinedit71.value:=0;
 if not floatdat then
 begin
   for i:=0 to maxclusters do
   begin
      showbmp[i].SetSize(0,0);
   end;

   rxspinedit67.MaxValue:=rxspinedit66.Value;
   if rxspinedit67.value> rxspinedit66.Value then rxspinedit67.Value:=rxspinedit66.Value;

   memo5.Color:=clred;
   memo5.Lines.add('Organising Kmeans');memo5.Update;
   kmeans1.numclusters:=trunc(rxspinedit66.value);	//clusters wanted by user (k of k-means)
   kmeans1.maxlines:=lcount;		//number of waveform records

   widthweight:=trunc(rxspinedit75.Value);
   //firstdatpt:=trunc(jvspinedit4.value);
   //lastdatpt:=trunc(jvspinedit5.value);
   kmeans1.firstdatpt:=10;
   kmeans1.lastdatpt:=specreclen+widthweight-1;
   if checkbox92.checked then
   begin
     kmeans1.firstdatpt:=0;
     kmeans1.lastdatpt:=trunc(jvspinedit1.value);
   end;
    //if true:faster clustering, if false: slower clustering SET THIS!!!
   kmeans1.ClusterMethodFlag:=checkbox93.checked;

   //if true, orphans are removed, if false not
   kmeans1.RemoveOrphans:=checkbox94.checked;

   //belongs to deorphanize. Is the minimum we still accept as a cluster
   kmeans1.minclustsize:=trunc(jvspinedit3.Value);

   setlength(kmeans1.iwork,kmeans1.maxlines+1);
   setlength(kmeans1.iscore,kmeans1.maxlines+1);
   pts:=(1+kmeans1.lastdatpt-kmeans1.firstdatpt);

   memo5.Lines.add('Init Kmeans');memo5.Update;
   setlength(kmeans1.sum,0,0);
   setlength(kmeans1.sum,7,(pts+1),kmeans1.numclusters+2);
   kmeans1.InitKMeans;
   sumtimecount:=0;

   cp.show;
   cp.rfjchart1.traces:=1;
   cp.rfjchart1.start:=0;
   cp.rfjchart1.eind:=rxspinedit74.Value;
   cp.rfjchart1.trace[1].ygmin:=0;
   cp.rfjchart1.trace[1].ygmax:=rxspinedit66.Value;
   cp.rfjchart1.drawmode:=dmbar;
   cp.rfjchart1.setuptraces;
   cp.rfjchart1.drawaxes;
   cp.rfjchart1.addstart(1,0,0);


   //kmeans1.avec1:=Tssevector.create(numdatpts);
   //kmeans1.avec2:=TFvector.create(numdatpts);

   //method: iterations
   if checkbox85.Checked then
   begin
    memo5.Lines.add('Using Iterations');memo5.Update;
    numclusters:=trunc(rxspinedit74.Value);;
    for k:=2 to numclusters  do
    begin
      kmeans1.DoKmeans;
      //it:=kmeans1.iteration;
      button84.Caption:='CLUSTER '+inttostr(k);label94.Update;
      //memo5.Lines.add('CLUSTER '+inttostr(it));memo5.Update;
      //pstat:=kmeans1.theDistances[it];
    end;
   end;

   //method: clusters
   if checkbox84.Checked then
   begin
    memo5.Lines.add('Using Clusters');memo5.Update;
    target:=trunc(rxspinedit66.Value);
    numclusters:=target;
    realclusters:=1;
    maxit:=trunc(rxspinedit74.Value);
    it:=0;
    while (realclusters<target) and (it<=maxit) do
    begin
      kmeans1.DoKmeans;
      realcount:=1;
      for i:=1 to lcount do
      begin
       testcount:=kmeans1.iwork[i];
       if (testcount>(realcount-1)) and (testcount<target) then inc(realcount);
      end;
      realclusters:=realcount;
      it:=kmeans1.iteration;
      button84.Caption:='CLUSTER '+inttostr(realclusters)+' ('+inttostr(it)+')';
      button84.Update;
      //
      cp.rfjchart1.addpoint(1,it,realclusters);
      cp.rfjchart1.update;
      //
      //memo5.Lines.add('CLUSTER '+inttostr(realclusters)+' ('+inttostr(it)+')');memo5.Update;
      //pstat:=kmeans1.theDistances[it];
      application.ProcessMessages;
    end;
   end;
   memo5.Lines.add('Handling Garbage');memo5.Update;
   if checkbox89.Checked then kmeans1.DistributeGarbage;
   memo5.Color:=clwhite;
   memo5.Lines.add('DONE');memo5.Update;
   button86click(self);
   cp.hide;
 end;

 if floatdat then
 begin
   for i:=0 to maxclusters do
   begin
      showbmp[i].SetSize(0,0);
   end;

   rxspinedit67.MaxValue:=rxspinedit66.Value;
   if rxspinedit67.value> rxspinedit66.Value then rxspinedit67.Value:=rxspinedit66.Value;

   memo5.Color:=clred;
   memo5.Lines.add('Organising Kmeans');memo5.Update;
   kmeans1F.numclusters:=trunc(rxspinedit66.value);	//clusters wanted by user (k of k-means)
   kmeans1F.maxlines:=lcount;		//number of waveform records

   widthweight:=trunc(rxspinedit75.Value);
   //firstdatpt:=trunc(jvspinedit4.value);
   //lastdatpt:=trunc(jvspinedit5.value);
   kmeans1F.firstdatpt:=0;
   kmeans1F.lastdatpt:=specreclen+widthweight-1;
   if checkbox92.checked then
   begin
     kmeans1F.firstdatpt:=0;
     kmeans1F.lastdatpt:=trunc(jvspinedit1.value);
   end;
    //if true:faster clustering, if false: slower clustering SET THIS!!!
   kmeans1F.ClusterMethodFlag:=checkbox93.checked;

   //if true, orphans are removed, if false not
   kmeans1F.RemoveOrphans:=checkbox94.checked;

   //belongs to deorphanize. Is the minimum we still accept as a cluster
   kmeans1F.minclustsize:=trunc(jvspinedit3.Value);

   setlength(kmeans1f.iwork,kmeans1F.maxlines+1);
   setlength(kmeans1f.iscore,kmeans1F.maxlines+1);
   pts:=(1+kmeans1F.lastdatpt-kmeans1F.firstdatpt);

   memo5.Lines.add('Init Kmeans');memo5.Update;
   setlength(kmeans1f.sum,0,0);
   setlength(kmeans1f.sum,7,(pts+1),kmeans1F.numclusters+2);
   kmeans1f.InitKMeans;
   sumtimecount:=0;

   cp.show;
   cp.rfjchart1.traces:=1;
   cp.rfjchart1.start:=0;
   cp.rfjchart1.eind:=rxspinedit74.Value;
   cp.rfjchart1.trace[1].ygmin:=0;
   cp.rfjchart1.trace[1].ygmax:=rxspinedit66.Value;
   cp.rfjchart1.drawmode:=dmbar;
   cp.rfjchart1.setuptraces;
   cp.rfjchart1.drawaxes;
   cp.rfjchart1.addstart(1,0,0);


   //kmeans1.avec1:=Tssevector.create(numdatpts);
   //kmeans1.avec2:=TFvector.create(numdatpts);

   //method: iterations
   if checkbox85.Checked then
   begin
    memo5.Lines.add('Using Iterations');memo5.Update;
    numclusters:=trunc(rxspinedit74.Value);;
    for k:=2 to numclusters  do
    begin
      kmeans1f.DoKmeans;
      //it:=kmeans1.iteration;
      button84.Caption:='CLUSTER '+inttostr(k);label94.Update;
      //memo5.Lines.add('CLUSTER '+inttostr(it));memo5.Update;
      //pstat:=kmeans1.theDistances[it];
    end;
   end;

   //method: clusters
   if checkbox84.Checked then
   begin
    memo5.Lines.add('Using Clusters');memo5.Update;
    target:=trunc(rxspinedit66.Value);
    kmeans1F.numclusters:=target;
    realclusters:=1;
    maxit:=trunc(rxspinedit74.Value);
    it:=0;
    while (realclusters<target) and (it<=maxit) do
    begin
      kmeans1f.DoKmeans;
      realcount:=1;
      for i:=1 to lcount do
      begin
       testcount:=kmeans1f.iwork[i];
       if (testcount>(realcount-1)) and (testcount<target) then inc(realcount);
      end;
      realclusters:=realcount;
      it:=kmeans1f.iteration;
      button84.Caption:='CLUSTER '+inttostr(realclusters)+' ('+inttostr(it)+')';
      button84.Update;
      //
      cp.rfjchart1.addpoint(1,it,realclusters);
      cp.rfjchart1.update;
      //
      //memo5.Lines.add('CLUSTER '+inttostr(realclusters)+' ('+inttostr(it)+')');memo5.Update;
      //pstat:=kmeans1.theDistances[it];
      application.ProcessMessages;
    end;
   end;
   memo5.Lines.add('Handling Garbage');memo5.Update;
   if checkbox89.Checked then kmeans1f.DistributeGarbage;
   memo5.Color:=clwhite;
   memo5.Lines.add('DONE');memo5.Update;
   button86click(self);
   cp.hide;
 end;
end;

//THIS IS NEVER USED???
//fix for float
procedure Tform1.subcluster(cluster:integer);
var i,j,k:integer;
    wp:integer;
    it:integer;
    noise:integer;
    pts,l:integer;
    st:string;
    c1,c2:integer;
    orphans:integer;
    t2,t1,freq:int64;
    elapsed:double;
    pstat:double;
    ymax,testval:double;
    tw,tw1,tw2:integer;
    teststring:string;
    wav:waveform;
    sumtime:double;
    sumtimecount:integer;
    test:smallint;
    indat:array [1..1] of specdata;
    specdat:array of specdata;
    bread:integer;
    spec:file;
    reclen:integer;
    totaltime:double;
    cfreq:int64;
    maxloc:integer;
    totalpoints:integer;
    setclusters:integer;
    old_iwork:array of integer;
    old_size:integer;
    old_maxlines:integer;
    subsize:integer;
    old_clusters:integer;
    p:integer;
    target,realclusters,realcount,maxit,testcount:integer;
begin
   //save iwork
   memo5.Color:=clred;
   memo5.Lines.add('Subcluster');memo5.Update;
   old_size:=high(kmeans1.iwork)+1;
   old_maxlines:=maxlines;
   old_clusters:=numclusters;
   setlength(old_iwork,high(kmeans1.iwork));
   for i:=0 to high(kmeans1.iwork) do
   begin
     old_iwork[i]:=kmeans1.iwork[i];
   end;

   //save dumdata?;
   setlength(old_dumdata, high(dumdata)+1);
   for i:=1 to high(dumdata) do
   begin
     old_dumdata[i]:=dumdata[i];
   end;

   //assign new data
   subsize:=0;
   for i:=1 to high(kmeans1.iwork) do
   begin
      if kmeans1.iwork[i]=cluster then inc(subsize);
   end;
   setlength(dumdata,subsize+1);
   p:=0;
   for i:=1 to high(kmeans1.iwork)-1 do
   begin
     if kmeans1.iwork[i]=cluster then
     begin
         inc(p);
         dumdata[p]:=old_dumdata[i];
     end;
   end;
   setlength(kmeans1.iwork,0);
   setlength(kmeans1.iwork,subsize+1);

   //lcount:=lcount-1;

   numclusters:=25;	//clusters wanted by user (k of k-means)
   maxlines:=subsize;
   firstdatpt:=0;		//first datapoint in the waveform used for the clustering (1..156)
   lastdatpt:=specreclen;	        //last datapoint in the waveform used for the clustering (1..256; lastdatpt > firstdatpt!!!)
   ClusterMethodFlag:=false;    //if true:faster clustering, if false: slower clustering SET THIS!!!
   RemoveOrphans:=true;	       //if true, orphans are removed, if false not
   minclustsize:=2;		//belongs to deorphanize. Is the minimum we still accept as a cluster
   pts:=(1+lastdatpt-firstdatpt);

   setlength(kmeans1.sum,7,(pts+1),numclusters+2);
   InitKMeans;
   sumtimecount:=0;
   //kmeans1.avec1:=Tssevector.create(numdatpts);
   //kmeans1.avec2:=TFvector.create(numdatpts);
   //for i:=1 to 100 do Tsum[i]:=0;
   //method: traget clusters

   //if checkbox85.Checked then
   begin
    target:=trunc(rxspinedit66.Value);
    numclusters:=target;
    realclusters:=1;
    maxit:=trunc(rxspinedit74.Value);
    realclusters:=1;
    realcount:=0;
    maxit:=200;
    it:=0;
    while (realclusters<target) and (it<=maxit) do
    begin
      DoKmeans;
      realcount:=1;
      for i:=1 to lcount do
      begin
       testcount:=kmeans1.iwork[i];
       if (testcount>(realcount-1)) and (testcount<target) then inc(realcount);
      end;
      realclusters:=realcount;
      it:=kmeans1.iteration;
      button84.Caption:='CLUSTER '+inttostr(realclusters)+' ('+inttostr(it)+')';
      button84.Update;
      //memo5.Lines.add('CLUSTER '+inttostr(realclusters)+' ('+inttostr(it)+')');memo5.Update;
      //pstat:=kmeans1.theDistances[it];
      application.ProcessMessages;
    end;
   end;
   memo5.lines.add('Handling Garbage');Memo5.update;
   kmeans1.DistributeGarbage;

   //now whtat to do with the results??

   //move current iwork into original iwork, stored in old_iwork
   for i:=0 to high(old_iwork) do
   begin
      if old_iwork[i]=cluster then
        if kmeans1.iwork[i]=0 then
          old_iwork[i]:=kmeans1.iwork[i]
        else
          old_iwork[i]:=kmeans1.iwork[i]+old_clusters;
   end;
   setlength(kmeans1.iwork,high(old_iwork));

   //copy back to iwork;
   for i:=0 to high(kmeans1.iwork) do
   begin
     kmeans1.iwork[i]:=old_iwork[i];
   end;
   numclusters:=old_clusters+numclusters-1;

   //copy old data back
   setlength(dumdata, high(old_dumdata)+1);
   for i:=1 to high(old_dumdata) do
   begin
     dumdata[i]:=old_dumdata[i];
   end;

   setlength(old_iwork,0);
   setlength(old_dumdata, 0);

   memo5.color:=clwhite;
   memo5.lines.Add('DONE');memo5.update ;
   button86click(self);
end;


procedure TForm1.Button85Click(Sender: TObject);
var i:integer;
    playcluster:integer;
    checkstate:boolean;
    x,y,x1,x2,y1,y2:integer;
    p:Tpoint;
    first:boolean;
    specrec:array[1..1] of specdata;
    specrecF:array[1..1] of specdata;
    spec:file;
    written:integer;
    result:boolean;
    cluswavpath:string;
begin
 if not floatdat then
 begin
  movie:=true;
  checkstate:=checkbox83.checked;
  checkbox83.checked:=true;
  playcluster:=trunc(rxspinedit71.value);
  first:=false;
  //
  //prepare for collection the wavs in to one large file
  //needs to be switched
  //
  sumwav:=wavefile.create;
  sumwav.Init;
  cluswavpath:=filepath+'\cluswav';
  CreateDir(cluswavpath);
  //TODO:delete old WAV files here
  sumwav.openforwrite(cluswavpath+'\Cluster_'+inttostr(trunc(rxspinedit71.Value))+'.wav',rate,16,1,result);

  //at least once
  for i:=1 to lcount do
  begin
      if kmeans1.iwork[i-1]=playcluster then
      begin
       if not first then
       begin
          assignfile(spec,specdatfile);
          reset(spec,sizeof(specdata));
          seek(spec,trunc(rxspinedit60.value)-1);
          blockread(spec,specrec[1],1);
          closefile(spec);
          //rxspinedit65.Value:=specrec[1].Duration+5;
          first:=true;
       end;

       rxspinedit60.value:=i;
       {
       x1:=area[playcluster,i].topleft.x;
       y1:=area[playcluster,i].topleft.y;
       x2:=area[playcluster,i].bottomright.x;
       y2:=area[playcluster,i].bottomright.y;
       imgview324.bitmap.FrameRectS(x1,y1,x2,y2,clred32);
       imgview324.Update;
       }
       {
       p.x:=(x1+x2) div 2;
       p.y:=(y1+y2) div 2;
       x:=imgview324.ClientToScreen(p).x;
       y:=imgview324.ClientToScreen(p).y;
       Setcursorpos(x,y);
       }
       application.ProcessMessages;
       if not form24.CheckBox2.Checked then
       begin
         sleep(trunc(rxspinedit65.value));
       end;
      end;
  end;

  sumwav.Close;
  sumwav.free;

  //and if needed, looping
  while checkbox86.Checked do
  for i:=1 to lcount+1 do
  begin
      if kmeans1.iwork[i-1]=playcluster then rxspinedit60.value:=i;
      image321.Update;
      sleep(20);
  end;
  checkbox83.checked:=checkstate;
  movie:=false;

  opendialog1.filename:='';
  fileread:=false;
  //showwave;
 end;

 if floatdat then
 begin
  movie:=true;
  checkstate:=checkbox83.checked;
  checkbox83.checked:=true;
  playcluster:=trunc(rxspinedit71.value);
  first:=false;
  //
  //prepare for collection the wavs in to one large file
  //needs to be switched
  //
  sumwav:=wavefile.create;
  sumwav.Init;
  cluswavpath:=filepath+'\cluswav';
  CreateDir(cluswavpath);
  //TODO:delete old WAV files here
  sumwav.openforwrite(cluswavpath+'\Cluster_'+inttostr(trunc(rxspinedit71.Value))+'.wav',rate,16,1,result);

  //at least once
  for i:=1 to lcount do
  begin
      if kmeans1F.iwork[i-1]=playcluster then
      begin
       if not first then
       begin
          assignfile(spec,specdatfile);
          reset(spec,sizeof(specdataF));
          seek(spec,trunc(rxspinedit60.value)-1);
          blockread(spec,specrecF[1],1);
          closefile(spec);
          //rxspinedit65.Value:=specrec[1].Duration+5;
          first:=true;
       end;

       rxspinedit60.value:=i;
       {
       x1:=area[playcluster,i].topleft.x;
       y1:=area[playcluster,i].topleft.y;
       x2:=area[playcluster,i].bottomright.x;
       y2:=area[playcluster,i].bottomright.y;
       imgview324.bitmap.FrameRectS(x1,y1,x2,y2,clred32);
       imgview324.Update;
       }
       {
       p.x:=(x1+x2) div 2;
       p.y:=(y1+y2) div 2;
       x:=imgview324.ClientToScreen(p).x;
       y:=imgview324.ClientToScreen(p).y;
       Setcursorpos(x,y);
       }
       application.ProcessMessages;
       if not form24.CheckBox2.Checked then
       begin
         sleep(trunc(rxspinedit65.value));
       end;
      end;
  end;

  sumwav.Close;
  sumwav.free;

  //and if needed, looping
  while checkbox86.Checked do
  for i:=1 to lcount+1 do
  begin
      if kmeans1F.iwork[i-1]=playcluster then rxspinedit60.value:=i;
      image321.Update;
      sleep(20);
  end;
  checkbox83.checked:=checkstate;
  movie:=false;

  opendialog1.filename:='';
  fileread:=false;
  //showwave;
 end;
end;



procedure TForm1.Button86Click(Sender: TObject);
var i,j,k:integer;
    cp:integer;
    clustercount:integer;
    cbmp:Tbitmap32;
    spec:file;
    specf:file;
    counter1,counter2:integer;
    specrec:array [1..1] of specdata;
    specrecf:array [1..1] of specdataf;
    filename,lastname:string;
    cluster,lastcluster:integer;
    totalwidth,rowsneeded, heightneeded:integer;
    day:Tdatetime;
    daysinmsec:int64;
    FileMsecOfYear:extended;
    bmpsize:array[0..maxclusters] of integer;
    bmpheights:array[0..maxclusters] of integer;
    scx,scy:array[0..maxclusters] of integer;
    syllablecount:array[0..maxclusters] of integer;
    score:integer;
    clusterpointer,bmppointer:integer;
    arraypointer1,arraypointer2:array of integer;
    teststring:string[32];
    dosort:boolean;
    t1,t2:int64;
    elapsed:double;
    totalcount:integer;
    savesort:file of byte;
    tiffbmp:Tbitmap;
    do_delete_special:boolean;
    trashpath,todir,fromdir:string;
    move_error:boolean;
    interval:double;
    targetbmp:integer;
    pmc: TProcessMemoryCounters;
    memoryusage:cardinal;
begin
 if not floatdat then
 begin
  //een testje
  // for i:=1 to lcount do
  // begin
  //   if (kmeans1.iscore[i-1]=0) and (kmeans1.iwork[i-1]=0) then
  //                                                           beep;
  // end;

   form30.Button1.Enabled:=true;

   memo5.color:=clred;
   memo5.Lines.add('Showing Clusters');memo5.Update;
   lastcluster:=-1;
   assignfile(spec,specdatfile);
   reset(spec,sizeof(specdata));

   rxspinedit71.MaxValue:=numclusters;

   totalwidth:=0;
   for i:=0 to numclusters do bmpsize[i]:=0;
   for i:=0 to numclusters do syllablecount[i]:=0;
   setlength(areatrack,lcount+1);

   if save_result then assignfile(savesort,'saveresult.bin');
   if save_result then rewrite(savesort);
   for i:=1 to lcount do
   begin
       cluster:=kmeans1.iwork[i-1];
       if save_result then blockwrite(savesort,kmeans1.iwork[i-1],1);

       totalwidth:=totalwidth+idbdata[i].width+5;
       bmpsize[cluster]:=bmpsize[cluster]+idbdata[i].width+5;
       inc(syllablecount[cluster]);
   end;
   if save_result then closefile(savesort);

   rowsneeded:=2+(totalwidth div imgview324.width) div 2;
   rowsneeded:=rowsneeded+numclusters;
   heightneeded:=trunc(0.60*rowsneeded*((idbdata[1].height)+5));
   if heightneeded<600 then heightneeded:=600;
   //
   for j:=0 to numclusters do
   begin
    if j>=0 then
    begin
      rowsneeded:=2+(bmpsize[j] div imgview324.width) div 2;
      //rowsneeded:=rowsneeded+numclusters;
      bmpheights[j]:=trunc(0.60*rowsneeded*((idbdata[1].height)+5));
      if (bmpheights[j]<600) and (syllablecount[j]>0) then bmpheights[j]:=600;
      if (syllablecount[j]=0) then bmpheights[j]:=0;
     end;
   end;
   //
   setlength(area,numclusters+1);
   for i:=0 to numclusters do setlength(area[i],syllablecount[i]+1);
   //
   memo5.Lines.add('Preparing Bitmaps');memo5.Update;

   //make bitmap
   if usemem then
    for i:=0 to numclusters do
    begin
        //showbmp[i]:=Tbitmap32.Create;
        showbmp[i].SetSize(imgview324.Width,bmpheights[i]);
        showbmp[i].Clear(clwhite32);
    end;

   if usedisk then
    for i:=0 to 250 do
    begin
      deletefile(filepath+'\cluster_'+inttostr(i)+'.bmp');  //rfj
    end;

   counter2:=0;

   //spreadsheet output to form24
   form24.AdvSpreadGrid1.Clear;
   form24.AdvSpreadGrid1.RowCount:=1;
   form24.AdvSpreadGrid1.colCount:=20; //9
   form24.advspreadgrid1.Cells[0,counter2]:='CLUSTER';
   form24.advspreadgrid1.Cells[1,counter2]:='FILENAME';
   form24.advspreadgrid1.Cells[2,counter2]:='SYLL.(DATETIME)';
   form24.advspreadgrid1.Cells[3,counter2]:='FILE(DATETIME)';
   form24.advspreadgrid1.Cells[4,counter2]:='MSEC_IN_YEAR';
   form24.advspreadgrid1.Cells[5,counter2]:='INTERVAL(MSEC)';
   form24.advspreadgrid1.Cells[6,counter2]:='WIDTH(PIXELS)';
   form24.advspreadgrid1.Cells[7,counter2]:='COUNT1';
   form24.advspreadgrid1.Cells[8,counter2]:='COUNT2';
   //
   form24.advspreadgrid1.ColWidths[6]:=60;
   form24.advspreadgrid1.ColWidths[7]:=60;
   form24.advspreadgrid1.ColWidths[8]:=60;
   //
   form24.advspreadgrid1.ColWidths[9]:=30;
   form24.advspreadgrid1.ColWidths[10]:=30;
   form24.advspreadgrid1.ColWidths[11]:=30;
   form24.advspreadgrid1.ColWidths[12]:=30;
   form24.advspreadgrid1.ColWidths[13]:=30;
   form24.advspreadgrid1.ColWidths[14]:=30;
   form24.advspreadgrid1.ColWidths[15]:=30;
   form24.advspreadgrid1.ColWidths[16]:=30;
   form24.advspreadgrid1.ColWidths[17]:=30;
   form24.advspreadgrid1.ColWidths[18]:=30;

   form24.advspreadgrid1.Cells[9,counter2]:='P1';
   form24.advspreadgrid1.Cells[10,counter2]:='P2';
   form24.advspreadgrid1.Cells[11,counter2]:='P3';
   form24.advspreadgrid1.Cells[12,counter2]:='P4';
   form24.advspreadgrid1.Cells[13,counter2]:='P5';
   form24.advspreadgrid1.Cells[14,counter2]:='P6';
   form24.advspreadgrid1.Cells[15,counter2]:='P7';
   form24.advspreadgrid1.Cells[16,counter2]:='P8';
   form24.advspreadgrid1.Cells[17,counter2]:='P9';
   form24.advspreadgrid1.Cells[18,counter2]:='';
   form24.advspreadgrid1.Cells[19,counter2]:='Distance';
   //
   form24.hide;

   queryperformancecounter(t1);
   //memo5.Lines.add('Getting Images'); memo5.Update;
   lastcluster:=-1;
   for j:=0 to numclusters do
   begin
    if usedisk then showbmp[j].SetSize(imgview324.Width,bmpheights[j]); //rfj
    if usedisk then showbmp[j].Clear(clwhite32);                        //rfj

    pmc.cb := SizeOf(pmc) ;
    if GetProcessMemoryInfo(GetCurrentProcess, @pmc, SizeOf(pmc)) then
       memoryusage := pmc.WorkingSetSize
    else
       RaiseLastOSError;

    statusbar1.Panels[2].Text:=FormatFloat('USED: ,.# Kb', MemoryUsage / 1024);
    statusbar1.Update;

    Memo5.Lines.add('Getting Images-'+inttostr(j));Memo5.update;
    scx[j]:=2;
    scy[j]:=2;
    label101.Caption:=inttostr(j)+' ('+inttostr(numclusters)+')';
    label101.Update;
    areacounter[j]:=0;
    if j<numclusters then showbmp[j].Textout(scx[j],scy[j],'THIS IS CLUSTER '+ inttostr(j)+ ' , with '+ inttostr(syllablecount[j])+' Items');
    if j=numclusters then showbmp[j].Textout(scx[j],scy[j],'THIS IS THE GARBAGE '+ inttostr(j)+ ' ,with '+inttostr(syllablecount[j])+' Items');
    scy[j]:=15;
    //
    for i:=0 to numclusters do
    begin
       setlength(clusterinfo,syllablecount[j]+1);
    end;
    //form26.Show;
    form26.advspreadgrid1.clear;
    form26.advspreadgrid1.rowcount:=0;
    form26.advspreadgrid1.colcount:=3;
    form26.advspreadgrid1.rowcount:=syllablecount[j]+2;
    clusterpointer:=0;

    dosort:=checkbox90.Checked;
    if checkbox88.Checked then
    begin
      form24.AdvSpreadGrid1.RowCount:=lcount+2;
      form30.AdvSpreadGrid1.RowCount:=lcount+2;
    end;

    for i:=1 to lcount do
    begin
     if (kmeans1.iwork[i-1]=j) then
     begin
       inc(clusterpointer);
       clusterinfo[clusterpointer].score:=kmeans1.iscore[i-1];
       clusterinfo[clusterpointer].width:=idbdata[i].width;
       clusterinfo[clusterpointer].cluster:=j;
       clusterinfo[clusterpointer].index:=i;
       form26.advspreadgrid1.Cells[0,clusterpointer]:=inttostr(clusterinfo[clusterpointer].index);
       form26.advspreadgrid1.Cells[1,clusterpointer]:=inttostr(clusterinfo[clusterpointer].width);
       form26.advspreadgrid1.Cells[2,clusterpointer]:=inttostr(clusterinfo[clusterpointer].score);
       form26.Update;
     end;
    end;
    if dosort then
    begin
     form26.advspreadgrid1.SortSettings.Column:=1;
     form26.advspreadgrid1.QSort;
     for i:=1 to form26.advspreadgrid1.rowcount do //syllablecount[j] do
     begin
        teststring:=form26.advspreadgrid1.cells[0,0];
        if teststring='' then
        begin
          form26.advspreadgrid1.RemoveRows(0,1);
          form26.advspreadgrid1.Update;
        end;
     end;
     form26.Update;
    end;

    //form26.advspreadgrid1.SaveToCSV('c:\temp\26.csv_b.csv');
    for i:=1 to form26.advspreadgrid1.rowcount do //syllablecount[j] do
    begin
        teststring:=form26.advspreadgrid1.cells[0,i-1];
        if teststring='' then
        begin
          form26.advspreadgrid1.RemoveRows(i-1,1);
          form26.advspreadgrid1.Update;
          //syllablecount[j]:=syllablecount[j]-1;
        end;
    end;
    form26.advspreadgrid1.Update;
    //form26.advspreadgrid1.SaveToCSV('c:\temp\26.csv_a.csv');
    //
    for i:=1 to syllablecount[j] do
    begin
     begin
        //bmppointer:=clusterinfo[i].index;
        inc(totalcount);
        teststring:=form26.advspreadgrid1.cells[0,i-1];
        bmppointer:=strtoint(teststring);
        cluster:=j;

        if usedisk then readimagebyindex(bmppointer);
        if usemem then memreadimagebyindex(bmppointer);

        if scy[j]<showbmp[j].Height then
        begin

           showbmp[j].Draw(
                     rect(scx[j],scy[j],scx[j]+idbbmp.Width div 2 ,scy[j]+idbbmp.height div 2),
                     rect(0,0,idbbmp.Width,idbbmp.height),
                     idbbmp
                     );

          // if idbbmp.width>50 then
          // begin
          //  showbmp[j].Textout(scx[j],scy[j]+10,inttostr(bmppointer));
          //  showbmp[j].Textout(scx[j],scy[j],inttostr(i));
          // end;

           //
           inc(areacounter[cluster]);
           area[cluster,areacounter[cluster]].topleft.X:=scx[j];
           area[cluster,areacounter[cluster]].topleft.y:=scy[j];
           area[cluster,areacounter[cluster]].bottomright.x:=scx[j]+idbbmp.Width div 2;
           area[cluster,areacounter[cluster]].bottomright.y:=scy[j]+idbbmp.height div 2;
           area[cluster,areacounter[cluster]].cluster:=j;
           area[cluster,areacounter[cluster]].item:=bmppointer;
           area[cluster,areacounter[cluster]].place:=i;
           areatrack[i]:=areacounter[cluster]; //reverse lookup;

           //area[areacounter].time:=round(specrec[1].Time);

           scx[j]:=scx[j]+(idbbmp.Width div 2)+2;
           if (scx[j]+idbbmp.Width)>showbmp[j].Width then
           begin
              scx[j]:=2;
              scy[j]:=scy[j]+(idbbmp.height div 2)+2;
           end;
           {
           scx[j]:=scx[j]+idbbmp.Width div 2+2;
           if (scx[j]+idbbmp.Width)>showbmp[j].Width then
           begin
              scx[j]:=2;
              scy[j]:=scy[j]+idbbmp.height div 2+2;
           end;
           }
        end;
        //
        seek(spec,bmppointer-1);
        blockread(spec,specrec[1],1);
        filename:=specrec[1].Filename;
        inc(counter1);

        //option for manfred
        if form24.CheckBox1.Checked and
                 checkbox88.Checked and
                 (trunc(rxspinedit71.Value)=j) and
                 fileexists(filepath+'\'+filename) then
        begin
          trashpath:=filepath+'\'+'clustered\';
          if not DirectoryExists(trashpath) then CreateDir(trashpath);
          //trashpath2:=ziphome+'\'+'trash'+'_'+zipname+'\';
          fromdir:=filepath+'\'+filename;
          todir:=trashpath+filename;
          windows.movefile(pchar(fromdir),pchar(todir));
        end;

        if checkbox88.Checked then
        begin
         inc(counter2);
         form24.advspreadgrid1.Cells[0,counter2]:=inttostr(j);
         form30.advspreadgrid1.Cells[0,counter2-1]:=inttostr(j);

         form24.advspreadgrid1.Cells[1,counter2]:=filename;
         form30.advspreadgrid1.Cells[1,counter2-1]:=filename;

         form24.advspreadgrid1.Cells[2,counter2]:=floattostr(specrec[1].Time);
         form30.advspreadgrid1.Cells[2,counter2-1]:=floattostr(specrec[1].Time);

         form24.advspreadgrid1.Cells[3,counter2]:=floattostr(filename2datetime(filename));
         day:=trunc(filename2datetime(filename));
         daysinmsec:=MilliSecondOfTheYear(day);
         FileMsecOfYear:=daysinmsec+specrec[1].Time;
         form24.advspreadgrid1.Cells[4,counter2]:=floattostr(FileMsecOfYear);
         if counter2>1 then
         begin
            Interval:=FileMsecOfYear-strtofloat(form24.advspreadgrid1.Cells[4,counter2-1]);
            form24.advspreadgrid1.Cells[5,counter2]:=floattostrf(Interval,fffixed,7,2);
            if Interval <0 then
            begin
              form24.advspreadgrid1.fontColors[5,counter2]:=clred;
            end;
            //form24.advspreadgrid1.Cells[5,counter2]:=floattostrf(FileMsecOfYear-strtofloat(form24.advspreadgrid1.Cells[4,counter2-1]),fffixed,7,2);
         end;
         form24.advspreadgrid1.Cells[7,counter2]:=inttostr(i);
         form24.advspreadgrid1.Cells[8,counter2]:=inttostr(totalcount);
         form24.advspreadgrid1.Cells[6,counter2]:=inttostr(idbbmp.Width);
         form30.advspreadgrid1.Cells[3,counter2-1]:=inttostr(idbbmp.Width);
         //
         for k:=0 to trunc(jvspinedit1.value) do
         begin
           form24.advspreadgrid1.Cells[k+9,counter2]:=inttostr(dumdata[bmppointer-1].wavform[k]);
           form24.advspreadgrid1.Cells[k+20,counter2]:=inttostr(dumdata2[bmppointer-1].wavform[k]);
         end;
       end;
     end;
    end;
     //form23.Show;
    if (syllablecount[j]>0) and (save_result) then
    begin
      //raw bmp, big,slow
      //showbmp[j].SaveToFile('c:\temp\cluster_'+inttostr(j)+'.bmp');

      //tiff. smaller, bit faster maybe?
      //tiffbmp:=Tbitmap.create;
      //showbmp[j].AssignTo(tiffbmp);
      //WriteTiffToFile('c:\temp\cluster_'+inttostr(j)+'.tiff',tiffbmp);
      //tiffbmp.free;

      //png, small
      tiffbmp:=Tbitmap.create;
      showbmp[j].AssignTo(tiffbmp);
      png.CompressionLevel:=9;
      png.Filters:=[pfNone, pfSub, pfUp, pfAverage, pfPaeth];
      PNG.assign(tiffbmp);
      png.SaveToFile(filepath+'\cluster_'+inttostr(j)+'.png');
      tiffbmp.free;
    end;
     if usedisk then showbmp[j].SaveToFile(filepath+'\cluster_'+inttostr(j)+'.bmp');  //rfj
     if usedisk then showbmp[j].setSize(0,0); //rfj
   end;
   queryperformancecounter(t2);
   elapsed:=(t2-t1) div lcount;
   form1.caption:=floattostr(elapsed);

   memo5.Lines.add('Copying Bitmap');memo5.Update;

   if usedisk then
   begin
     targetbmp:=trunc(rxspinedit71.value); //rfj
     showbmp[targetbmp].LoadFromFile(filepath+'\cluster_'+inttostr(targetbmp)+'.bmp');  //rfj
     imgview324.bitmap.Assign(showbmp[targetbmp]); //rfj
     imgview324.Update;
   end;

   if usemem then
   begin
     imgview324.bitmap.Assign(showbmp[trunc(rxspinedit71.value)]);
     imgview324.Update;
   end;

   application.processmessages;
   memo5.Lines.add('Showing data');memo5.Update;
   if checkbox88.Checked then form24.Show;
   //form25.show;
   form30.show;
   closefile(spec);
   memo5.color:=clwhite;
   memo5.Lines.add('DONE');
 end;

 if floatdat then
 begin
  //een testje
  // for i:=1 to lcount do
  // begin
  //   if (kmeans1.iscore[i-1]=0) and (kmeans1.iwork[i-1]=0) then
  //                                                           beep;
  // end;

   form30.Button1.Enabled:=true;

   memo5.color:=clred;
   memo5.Lines.add('Showing Clusters');memo5.Update;
   lastcluster:=-1;
   assignfile(specf,specdatfile);
   reset(specf,sizeof(specdataf));

   rxspinedit71.MaxValue:=numclusters;

   totalwidth:=0;
   for i:=0 to numclusters do bmpsize[i]:=0;
   for i:=0 to numclusters do syllablecount[i]:=0;
   setlength(areatrack,lcount+1);

   if save_result then assignfile(savesort,'saveresult.bin');
   if save_result then rewrite(savesort);
   for i:=1 to lcount do
   begin
       cluster:=kmeans1f.iwork[i-1];
       if save_result then blockwrite(savesort,kmeans1f.iwork[i-1],1);

       totalwidth:=totalwidth+idbdata[i].width+5;
       bmpsize[cluster]:=bmpsize[cluster]+idbdata[i].width+5;
       inc(syllablecount[cluster]);
   end;
   if save_result then closefile(savesort);

   rowsneeded:=2+(totalwidth div imgview324.width) div 2;
   rowsneeded:=rowsneeded+numclusters;
   heightneeded:=trunc(0.60*rowsneeded*((idbdata[1].height)+5));
   if heightneeded<600 then heightneeded:=600;
   //
   for j:=0 to numclusters do
   begin
    if j>=0 then
    begin
      rowsneeded:=2+(bmpsize[j] div imgview324.width) div 2;
      //rowsneeded:=rowsneeded+numclusters;
      bmpheights[j]:=trunc(0.60*rowsneeded*((idbdata[1].height)+5));
      if (bmpheights[j]<600) and (syllablecount[j]>0) then bmpheights[j]:=600;
      if (syllablecount[j]=0) then bmpheights[j]:=0;
     end;
   end;
   //
   setlength(area,numclusters+1);
   for i:=0 to numclusters do setlength(area[i],syllablecount[i]+1);
   //
   memo5.Lines.add('Preparing Bitmaps');memo5.Update;

   //make bitmap
   if usemem then                                          //  rfj
    for i:=0 to numclusters do
    begin
        //showbmp[i]:=Tbitmap32.Create;
        showbmp[i].SetSize(imgview324.Width,bmpheights[i]);
        showbmp[i].Clear(clwhite32);
    end;

   if usedisk then
    for i:=0 to 250 do
    begin
      deletefile(filepath+'\cluster_'+inttostr(i)+'.bmp');  //rfj
    end;

   counter2:=0;

   //spreadsheet output to form24
   form24.AdvSpreadGrid1.Clear;
   form24.AdvSpreadGrid1.RowCount:=1;
   form24.AdvSpreadGrid1.colCount:=20; //9
   form24.advspreadgrid1.Cells[0,counter2]:='CLUSTER';
   form24.advspreadgrid1.Cells[1,counter2]:='FILENAME';
   form24.advspreadgrid1.Cells[2,counter2]:='SYLL.(DATETIME)';
   form24.advspreadgrid1.Cells[3,counter2]:='FILE(DATETIME)';
   form24.advspreadgrid1.Cells[4,counter2]:='MSEC_IN_YEAR';
   form24.advspreadgrid1.Cells[5,counter2]:='INTERVAL(MSEC)';
   form24.advspreadgrid1.Cells[6,counter2]:='WIDTH(PIXELS)';
   form24.advspreadgrid1.Cells[7,counter2]:='COUNT1';
   form24.advspreadgrid1.Cells[8,counter2]:='COUNT2';
   //
   form24.advspreadgrid1.ColWidths[6]:=60;
   form24.advspreadgrid1.ColWidths[7]:=60;
   form24.advspreadgrid1.ColWidths[8]:=60;
   //
   form24.advspreadgrid1.ColWidths[9]:=30;
   form24.advspreadgrid1.ColWidths[10]:=30;
   form24.advspreadgrid1.ColWidths[11]:=30;
   form24.advspreadgrid1.ColWidths[12]:=30;
   form24.advspreadgrid1.ColWidths[13]:=30;
   form24.advspreadgrid1.ColWidths[14]:=30;
   form24.advspreadgrid1.ColWidths[15]:=30;
   form24.advspreadgrid1.ColWidths[16]:=30;
   form24.advspreadgrid1.ColWidths[17]:=30;
   form24.advspreadgrid1.ColWidths[18]:=30;

   form24.advspreadgrid1.Cells[9,counter2]:='P1';
   form24.advspreadgrid1.Cells[10,counter2]:='P2';
   form24.advspreadgrid1.Cells[11,counter2]:='P3';
   form24.advspreadgrid1.Cells[12,counter2]:='P4';
   form24.advspreadgrid1.Cells[13,counter2]:='P5';
   form24.advspreadgrid1.Cells[14,counter2]:='P6';
   form24.advspreadgrid1.Cells[15,counter2]:='P7';
   form24.advspreadgrid1.Cells[16,counter2]:='P8';
   form24.advspreadgrid1.Cells[17,counter2]:='P9';
   form24.advspreadgrid1.Cells[18,counter2]:='';
   form24.advspreadgrid1.Cells[19,counter2]:='Distance';
   //
   form24.hide;

   queryperformancecounter(t1);
   //memo5.Lines.add('Getting Images'); memo5.Update;
   lastcluster:=-1;
   for j:=0 to numclusters do
   begin
    if usedisk then showbmp[j].SetSize(imgview324.Width,bmpheights[j]); //rfj
    if usedisk then showbmp[j].Clear(clwhite32);                        //rfj

    pmc.cb := SizeOf(pmc) ;
    if GetProcessMemoryInfo(GetCurrentProcess, @pmc, SizeOf(pmc)) then
       memoryusage := pmc.WorkingSetSize
    else
       RaiseLastOSError;

    statusbar1.Panels[2].Text:=FormatFloat('USED: ,.# Kb', MemoryUsage / 1024);
    statusbar1.Update;


    Memo5.Lines.add('Getting Images-'+inttostr(j));Memo5.update;
    scx[j]:=2;
    scy[j]:=2;
    label101.Caption:=inttostr(j)+' ('+inttostr(numclusters)+')';
    label101.Update;
    areacounter[j]:=0;
    if j<numclusters then showbmp[j].Textout(scx[j],scy[j],'THIS IS CLUSTER '+ inttostr(j)+ ' , with '+ inttostr(syllablecount[j])+' Items');
    if j=numclusters then showbmp[j].Textout(scx[j],scy[j],'THIS IS THE GARBAGE '+ inttostr(j)+ ' ,with '+inttostr(syllablecount[j])+' Items');
    scy[j]:=15;
    //
    for i:=0 to numclusters do
    begin
       setlength(clusterinfo,syllablecount[j]+1);
    end;
    //form26.Show;
    form26.advspreadgrid1.clear;
    form26.advspreadgrid1.rowcount:=0;
    form26.advspreadgrid1.colcount:=3;
    form26.advspreadgrid1.rowcount:=syllablecount[j]+2;
    clusterpointer:=0;

    dosort:=checkbox90.Checked;
    if checkbox88.Checked then
    begin
      form24.AdvSpreadGrid1.RowCount:=lcount+2;
      form30.AdvSpreadGrid1.RowCount:=lcount+2;
    end;

    for i:=1 to lcount do
    begin
     if (kmeans1f.iwork[i-1]=j) then
     begin
       inc(clusterpointer);
       clusterinfo[clusterpointer].score:=kmeans1f.iscore[i-1];
       clusterinfo[clusterpointer].width:=idbdata[i].width;
       clusterinfo[clusterpointer].cluster:=j;
       clusterinfo[clusterpointer].index:=i;
       form26.advspreadgrid1.Cells[0,clusterpointer]:=inttostr(clusterinfo[clusterpointer].index);
       form26.advspreadgrid1.Cells[1,clusterpointer]:=inttostr(clusterinfo[clusterpointer].width);
       form26.advspreadgrid1.Cells[2,clusterpointer]:=inttostr(clusterinfo[clusterpointer].score);
       form26.Update;
     end;
    end;
    if dosort then
    begin
     form26.advspreadgrid1.SortSettings.Column:=1;
     form26.advspreadgrid1.QSort;
     for i:=1 to form26.advspreadgrid1.rowcount do //syllablecount[j] do
     begin
        teststring:=form26.advspreadgrid1.cells[0,0];
        if teststring='' then
        begin
          form26.advspreadgrid1.RemoveRows(0,1);
          form26.advspreadgrid1.Update;
        end;
     end;
     form26.Update;
    end;

    //form26.advspreadgrid1.SaveToCSV('c:\temp\26.csv_b.csv');
    for i:=1 to form26.advspreadgrid1.rowcount do //syllablecount[j] do
    begin
        teststring:=form26.advspreadgrid1.cells[0,i-1];
        if teststring='' then
        begin
          form26.advspreadgrid1.RemoveRows(i-1,1);
          form26.advspreadgrid1.Update;
          //syllablecount[j]:=syllablecount[j]-1;
        end;
    end;
    form26.advspreadgrid1.Update;
    //form26.advspreadgrid1.SaveToCSV('c:\temp\26.csv_a.csv');
    //
    for i:=1 to syllablecount[j] do
    begin
     begin
        //bmppointer:=clusterinfo[i].index;
        inc(totalcount);
        teststring:=form26.advspreadgrid1.cells[0,i-1];
        bmppointer:=strtoint(teststring);
        cluster:=j;

        if usedisk then readimagebyindex(bmppointer);
        if usemem then memreadimagebyindex(bmppointer);

        if scy[j]<showbmp[j].Height then
        begin

           showbmp[j].Draw(
                     rect(scx[j],scy[j],scx[j]+idbbmp.Width div 2 ,scy[j]+idbbmp.height div 2),
                     rect(0,0,idbbmp.Width,idbbmp.height),
                     idbbmp
                     );

          // if idbbmp.width>50 then
          // begin
          //  showbmp[j].Textout(scx[j],scy[j]+10,inttostr(bmppointer));
          //  showbmp[j].Textout(scx[j],scy[j],inttostr(i));
          // end;

           //
           inc(areacounter[cluster]);
           area[cluster,areacounter[cluster]].topleft.X:=scx[j];
           area[cluster,areacounter[cluster]].topleft.y:=scy[j];
           area[cluster,areacounter[cluster]].bottomright.x:=scx[j]+idbbmp.Width div 2;
           area[cluster,areacounter[cluster]].bottomright.y:=scy[j]+idbbmp.height div 2;
           area[cluster,areacounter[cluster]].cluster:=j;
           area[cluster,areacounter[cluster]].item:=bmppointer;
           area[cluster,areacounter[cluster]].place:=i;
           areatrack[i]:=areacounter[cluster]; //reverse lookup;

           //area[areacounter].time:=round(specrec[1].Time);

           scx[j]:=scx[j]+(idbbmp.Width div 2)+2;
           if (scx[j]+idbbmp.Width)>showbmp[j].Width then
           begin
              scx[j]:=2;
              scy[j]:=scy[j]+(idbbmp.height div 2)+2;
           end;
           {
           scx[j]:=scx[j]+idbbmp.Width div 2+2;
           if (scx[j]+idbbmp.Width)>showbmp[j].Width then
           begin
              scx[j]:=2;
              scy[j]:=scy[j]+idbbmp.height div 2+2;
           end;
           }
        end;
        //
        seek(specf,bmppointer-1);
        blockread(specf,specrecf[1],1);
        filename:=specrecf[1].Filename;
        inc(counter1);

        //option for manfred
        if form24.CheckBox1.Checked and
                 checkbox88.Checked and
                 (trunc(rxspinedit71.Value)=j) and
                 fileexists(filepath+'\'+filename) then
        begin
          trashpath:=filepath+'\'+'clustered\';
          if not DirectoryExists(trashpath) then CreateDir(trashpath);
          //trashpath2:=ziphome+'\'+'trash'+'_'+zipname+'\';
          fromdir:=filepath+'\'+filename;
          todir:=trashpath+filename;
          windows.movefile(pchar(fromdir),pchar(todir));
        end;

        if checkbox88.Checked then
        begin
         inc(counter2);
         form24.advspreadgrid1.Cells[0,counter2]:=inttostr(j);
         form30.advspreadgrid1.Cells[0,counter2-1]:=inttostr(j);

         form24.advspreadgrid1.Cells[1,counter2]:=filename;
         form30.advspreadgrid1.Cells[1,counter2-1]:=filename;

         form24.advspreadgrid1.Cells[2,counter2]:=floattostr(specrecf[1].Time);
         form30.advspreadgrid1.Cells[2,counter2-1]:=floattostr(specrecf[1].Time);

         form24.advspreadgrid1.Cells[3,counter2]:=floattostr(filename2datetime(filename));
         day:=trunc(filename2datetime(filename));
         daysinmsec:=MilliSecondOfTheYear(day);
         FileMsecOfYear:=daysinmsec+specrecf[1].Time;       //typo fixed feb 28 2008
         form24.advspreadgrid1.Cells[4,counter2]:=floattostr(FileMsecOfYear);
         if counter2>1 then
         begin
            Interval:=FileMsecOfYear-strtofloat(form24.advspreadgrid1.Cells[4,counter2-1]);
            form24.advspreadgrid1.Cells[5,counter2]:=floattostrf(Interval,fffixed,7,2);
            if Interval <0 then
            begin
              form24.advspreadgrid1.fontColors[5,counter2]:=clred;
            end;
         end;
         form24.advspreadgrid1.Cells[7,counter2]:=inttostr(i);
         form24.advspreadgrid1.Cells[8,counter2]:=inttostr(totalcount);
         form24.advspreadgrid1.Cells[6,counter2]:=inttostr(idbbmp.Width);
         form30.advspreadgrid1.Cells[3,counter2-1]:=inttostr(idbbmp.Width);
         //
         for k:=0 to trunc(jvspinedit1.value) do
         begin
           form24.advspreadgrid1.Cells[k+9,counter2]:=floattostr(dumdataF[bmppointer-1].wavformF[k]);
           form24.advspreadgrid1.Cells[k+20,counter2]:=floattostr(dumdata2F[bmppointer-1].wavformF[k]);
         end;
       end;
     end;
    end;
     //form23.Show;
    if (syllablecount[j]>0) and (save_result) then
    begin
      //raw bmp, big,slow
      if usedisk then
                  showbmp[j].SaveToFile(filepath+'\cluster_'+inttostr(j)+'.bmp');

      //tiff. smaller, bit faster maybe?
      //tiffbmp:=Tbitmap.create;
      //showbmp[j].AssignTo(tiffbmp);
      //WriteTiffToFile('c:\temp\cluster_'+inttostr(j)+'.tiff',tiffbmp);
      //tiffbmp.free;

      //png, small
      if usemem then
      begin
        tiffbmp:=Tbitmap.create;
        showbmp[j].AssignTo(tiffbmp);
        png.CompressionLevel:=9;
        png.Filters:=[pfNone, pfSub, pfUp, pfAverage, pfPaeth];
        PNG.assign(tiffbmp);
        png.SaveToFile(filepath+'\cluster_'+inttostr(j)+'.png');
        tiffbmp.free;
      end;
    end;
    if usedisk then showbmp[j].SaveToFile(filepath+'\cluster_'+inttostr(j)+'.bmp');  //rfj
    if usedisk then showbmp[j].setSize(0,0); //rfj
   end;
   queryperformancecounter(t2);
   elapsed:=(t2-t1) div lcount;
   form1.caption:=floattostr(elapsed);

   memo5.Lines.add('Copying Bitmap');memo5.Update;

   if usedisk then
   begin
     targetbmp:=trunc(rxspinedit71.value); //rfj
     showbmp[targetbmp].LoadFromFile(filepath+'\cluster_'+inttostr(targetbmp)+'.bmp');  //rfj
     imgview324.bitmap.Assign(showbmp[targetbmp]); //rfj
     imgview324.Update;
   end;

   if usemem then
   begin
     imgview324.bitmap.Assign(showbmp[trunc(rxspinedit71.value)]);
     imgview324.Update;
   end;

   application.processmessages;
   memo5.Lines.add('Showing data');memo5.Update;
   if checkbox88.Checked then form24.Show;
   //form25.show;
   form30.show;
   closefile(specf);
   memo5.color:=clwhite;
   memo5.Lines.add('DONE');
 end;
end;


procedure TForm1.ImgView324DblClick(Sender: TObject);
begin
   imgview324.Bitmap.SaveToFile('result.bmp');
end;

procedure TForm1.ImgView324MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer; Layer: TCustomLayer);
var  i,k,x1,y1,x2,y2:integer;
     recordnumber:integer;
     time:double;
     cluster:integer;
begin
 pmx1:=mx1;
 pmy1:=my1;
 mx1:=round((imgview324.HScroll.Position+x)/imgview324.Scale);
 my1:=round((imgview324.VScroll.Position+y)/imgview324.Scale);
 cluster:=trunc(rxspinedit71.value);
 if (pmy1<>my1) or (pmx1<>mx1) then
 begin
   for i:=1 to areacounter[cluster] do
   begin
     x1:=area[cluster,i].topleft.x;
     y1:=area[cluster,i].topleft.y;
     x2:=area[cluster,i].bottomright.x;
     y2:=area[cluster,i].bottomright.y;
     if (x1>0) and (x1<imgview324.bitmap.width) then
       if (x2>0) and (x2<imgview324.bitmap.width) then
        if (y1>0) and (y1<imgview324.bitmap.height) then
         if (y2>0) and (y2<imgview324.bitmap.height) then
           if (mx1>x1) and (mx1<x2) and (my1>y1) and (my1<y2) then
            begin
              RxSpinEdit60.value:=area[cluster,i].item;
              currentitem:=area[cluster,i].place;
              currentx1:=x1;
              currentx2:=x2;
              currenty1:=y1;
              currenty2:=y2;
            end;
    end;
 end;
end;



procedure TForm1.ImgView325MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var  i,k,x1,y1,x2,y2:integer;
     recordnumber:integer;
     time:double;
     cluster:integer;
     //
     specrec:array [1..1] of specdata;
     specrecF:array [1..1] of specdataF;
     filename:string;
     start,eind:double;
     clip:wavefile;
     written:integer;
     result:boolean;
     timestring:string;
     whrs,wmin,wsec,secinday,msecinday:integer;
     rec,playcluster:integer;
     wbuffer:array[1..441] of smallint;
     checkstate:boolean;
     wavfile,shortwavfile:string;
     dt:Tdatetime;
     extsyllduur:integer;
     extmsecinday,extbitmaptime,extsylltime:double;
     wavnamelength:integer;
begin
{
 pmx1:=mx1;
 pmy1:=my1;
 mx1:=round((imgview325.HScroll.Position+x)/imgview325.Scale);
 my1:=round((imgview325.VScroll.Position+y)/imgview325.Scale);
 cluster:=trunc(rxspinedit77.value);
 if (pmy1<>my1) or (pmx1<>mx1) then
 begin
   for i:=1 to extareacounter[cluster] do
   begin
     x1:=extarea[cluster,i].topleft.x;
     y1:=extarea[cluster,i].topleft.y;
     x2:=extarea[cluster,i].bottomright.x;
     y2:=extarea[cluster,i].bottomright.y;
     if (x1>0) and (x1<imgview325.bitmap.width) then
       if (x2>0) and (x2<imgview325.bitmap.width) then
        if (y1>0) and (y1<imgview325.bitmap.height) then
         if (y2>0) and (y2<imgview325.bitmap.height) then
           if (mx1>x1) and (mx1<x2) and (my1>y1) and (my1<y2) then
            begin
              //RxSpinEdit60.value:=area[cluster,i].item;
              currentitem:=extarea[cluster,i].item;
              form30.AdvSpreadGrid1.SelectRows(currentitem-1,1);
              form30.AdvSpreadgrid1.ScrollInView(0,currentitem-1);
              Form30.AdvSpreadGrid1ClickCell(self,currentitem-1,1);
              currentx1:=x1;
              currentx2:=x2;
              currenty1:=y1;
              currenty2:=y2;
              break;
            end;
    end;
 end;

wavfile:=uppercase(form30.AdvSpreadgrid1.Cells[1,currentitem-1]);
if wavfile<>'' then
begin
 //before the threads starts
 InitializeCriticalSection(CriticalSection);

 shortwavfile:=wavfile;
 if AnsiEndsStr('.WAV',WavFile) then
 begin
  wavnamelength:=length(wavfile);
  shortwavfile:=copy(wavfile,1,wavnamelength-4);
 end;

 extmsecinday:=filename2msecinday(shortwavfile);
 extbitmaptime:=strtofloat(form30.advspreadgrid1.cells[2,currentitem-1]);
 extsyllduur:=strtoint(form30.advspreadgrid1.cells[3,currentitem-1]);
 extsylltime:=extbitmaptime-extmsecinday;

 checkstate:=checkbox53.Checked;
 checkbox53.Checked:=false; //force daytime reading

 opendialog1.filename:=wavfile;
 If not FileExists(wavfile) then
        ShowMessage('FILE NOT FOUND ('+wavfile+')')
 else
   begin
    showwave;
    fileread:=false;
    start:=extsylltime;
    eind:=start+(2*extsyllduur);
    Eindsample:=trunc(eind*rate/1000);
    Startsample:=trunc(start*rate/1000);
    checkbox53.Checked:=checkstate; //reset this
    EnterCriticalSection(CriticalSection);
     result:=false;
     begin
      clip:=wavefile.create;
      clip.Init;
      clip.openforwrite('$$$.wav',rate,16,1,result);
      if result then clip.WriteSampledata((eindsample-startsample),written,wavdata[startsample]);
      if (written<>(eindsample-startsample)) then result:=false;
      clip.Close;
      clip.free;
     end;
     if result then
     begin
       jvwaveplayer1.Asynchronous:=true;
       if fileexists('$$$.wav') then
       begin
        jvwaveplayer1.FileName:='$$$.wav';
        jvwaveplayer1.Play;
       end;
     end;
    end;
    //End of safe block
    LeaveCriticalSection(CriticalSection);
 end;
}
end;


procedure TForm1.ImgView325MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
var  i,k,x1,y1,x2,y2:integer;
     recordnumber:integer;
     time:double;
     cluster:integer;
     //
     specrec:array [1..1] of specdata;
     specrecF:array [1..1] of specdataF;
     filename:string;
     start,eind:double;
     clip:wavefile;
     written:integer;
     result:boolean;
     timestring:string;
     whrs,wmin,wsec,secinday,msecinday:integer;
     rec,playcluster:integer;
     wbuffer:array[1..441] of smallint;
     checkstate:boolean;
     wavfile,shortwavfile:string;
     dt:Tdatetime;
     extsyllduur:integer;
     extmsecinday,extbitmaptime,extsylltime:double;
     wavnamelength:integer;
begin
 if not loadingexternaldata then
 begin
  pmx1:=mx1;
  pmy1:=my1;
  mx1:=round((imgview325.HScroll.Position+x)/imgview325.Scale);
  my1:=round((imgview325.VScroll.Position+y)/imgview325.Scale);
  cluster:=trunc(rxspinedit77.value);
  if (pmy1<>my1) or (pmx1<>mx1) then
  begin
   for i:=1 to extareacounter[cluster] do
   begin
     x1:=extarea[cluster,i].topleft.x;
     y1:=extarea[cluster,i].topleft.y;
     x2:=extarea[cluster,i].bottomright.x;
     y2:=extarea[cluster,i].bottomright.y;
     if (x1>0) and (x1<imgview325.bitmap.width) then
       if (x2>0) and (x2<imgview325.bitmap.width) then
        if (y1>0) and (y1<imgview325.bitmap.height) then
         if (y2>0) and (y2<imgview325.bitmap.height) then
           if (mx1>x1) and (mx1<x2) and (my1>y1) and (my1<y2) then
            begin
              //RxSpinEdit60.value:=area[cluster,i].item;
              currentitem:=extarea[cluster,i].item;
              if currentitem<>previtem then
              begin
                wavfile:=uppercase(form30.AdvSpreadgrid1.Cells[1,currentitem-1]);
                form30.AdvSpreadGrid1.SelectRows(currentitem-1,1);
                form30.AdvSpreadgrid1.ScrollInView(0,currentitem-1);
                Form30.AdvSpreadGrid1ClickCell(self,currentitem-1,1);
              end;
              previtem:=currentitem;
              currentx1:=x1;
              currentx2:=x2;
              currenty1:=y1;
              currenty2:=y2;
              break;
            end;
    end;
  end;

 if wavfile <>'' then
 begin
  //before the threads starts
  InitializeCriticalSection(CriticalSection);

  shortwavfile:=wavfile;
  if AnsiEndsStr('.WAV',WavFile) then
  begin
   wavnamelength:=length(wavfile);
   shortwavfile:=copy(wavfile,1,wavnamelength-4);
  end;

  extmsecinday:=filename2msecinday(shortwavfile);
  extbitmaptime:=strtofloat(form30.advspreadgrid1.cells[2,currentitem-1]);
  extsyllduur:=strtoint(form30.advspreadgrid1.cells[3,currentitem-1]);
  extsylltime:=extbitmaptime-extmsecinday;

  checkstate:=checkbox53.Checked;
  checkbox53.Checked:=false; //force daytime reading

  opendialog1.filename:=wavfile;
  If not FileExists(wavfile) then
        ShowMessage('FILE NOT FOUND ('+wavfile+')')
  else
   begin
    showwave;
    fileread:=false;
    start:=extsylltime;
    eind:=start+(2*extsyllduur);
    Eindsample:=trunc(eind*rate/1000);
    Startsample:=trunc(start*rate/1000);
    checkbox53.Checked:=checkstate; //reset this
    EnterCriticalSection(CriticalSection);
     result:=false;
     begin
      clip:=wavefile.create;
      clip.Init;
      clip.openforwrite('$$$.wav',rate,16,1,result);
      if result then clip.WriteSampledata((eindsample-startsample),written,wavdata[startsample]);
      if (written<>(eindsample-startsample)) then result:=false;
      clip.Close;
      clip.free;
     end;
     if result then
      begin
       jvwaveplayer1.Asynchronous:=true;
       if fileexists('$$$.wav') then
       begin
        jvwaveplayer1.FileName:='$$$.wav';
        jvwaveplayer1.Play;
       end;
      end;
     end;
    LeaveCriticalSection(CriticalSection);
  end;
  end;
end;


procedure TForm1.ImgView324Click(Sender: TObject);
var x1,y1,x2,y2:integer;
    cluster,k,item:integer;
begin
 if rxspinedit67.value> rxspinedit66.Value then
                          rxspinedit67.Value:=rxspinedit66.Value;
 cluster:=trunc(rxspinedit71.value);
 item:=area[cluster,currentitem].item;

 if not floatdat then
 begin
  if kmeans1.iwork[item-1]=cluster then
   begin
    kmeans1.iwork[item-1]:=trunc(rxspinedit67.value);
    showbmp[cluster].LineS(currentx1,currenty1,currentx2,currenty2,clred32);
    showbmp[cluster].LineS(currentx2,currenty1,currentx1,currenty2,clred32);
   end
  else
   begin
    kmeans1.iwork[item-1]:=cluster;
    showbmp[cluster].LineS(currentx1,currenty1,currentx2,currenty2,clwhite32);
    showbmp[cluster].LineS(currentx2,currenty1,currentx1,currenty2,clwhite32);
   end;
 end;
 if floatdat then
 begin
  if kmeans1F.iwork[item-1]=cluster then
   begin
    kmeans1F.iwork[item-1]:=trunc(rxspinedit67.value);
    showbmp[cluster].LineS(currentx1,currenty1,currentx2,currenty2,clred32);
    showbmp[cluster].LineS(currentx2,currenty1,currentx1,currenty2,clred32);
   end
  else
   begin
    kmeans1F.iwork[item-1]:=cluster;
    showbmp[cluster].LineS(currentx1,currenty1,currentx2,currenty2,clwhite32);
    showbmp[cluster].LineS(currentx2,currenty1,currentx1,currenty2,clwhite32);
   end;
 end;
 imgview324.bitmap.Assign(showbmp[trunc(rxspinedit71.value)]);

end;

procedure TForm1.RxSpinEdit68Change(Sender: TObject);
var i:integer;
begin
   rfjchart12.traces:=1;
   rfjchart12.buffered:=true;
   rfjchart12.eind:=200;
   rfjchart12.trace[1].ygmin:=0;
   rfjchart12.trace[1].ygmax:=trunc(rxspinedit68.Value);;
   rfjchart12.drawmode:=dmskyline;
   rfjchart12.setuptraces;
   rfjchart12.drawaxes;
   rfjchart12.addstart(1,0,0);
   for i:=1 to 200 do
   begin
      rfjchart12.addpoint(1,i,idbbinhis[i]);
   end;
   rfjchart12.update;
end;

function Tform1.filename2msecinday(filename:string):int64;
var
     datmedian:smallint;
     testdata:int64array;
     rmed:integer;
     ext:string;
     sr:Tsearchrec;
     read:integer;
     minutes:extended;
     seconds:extended;
     maxfilenamelength:array[0..10] of integer;
     testwidth:integer;
     day,month,yr,hrs,min,sec,timestring,datestring:string;
     wyear,wday,wmonth,wyr,whrs,wmin,wsec:word;
     datetime:Tdatetime;
     secinday,msecinday:int64;
     f1datetime:Tdatetime;
     maand:integer;
     wmsec:word;
     testchar:char;
     testval:byte;
     offset:string;
     woffset:integer;
     wtimestring:int64;
begin
{
                    Offset:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],7,7,'_');
                    offset:=z_ItemCGetFmTo(offset,0,0,'-');
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    woffset:=strtoint(offset);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=(1000*secinday)+woffset;

}
           if ((z_ItemCCount(filename,'_')-1)=7)  then
           begin
            //optie 1: het eerste woord na de underscore bevat een letter
            //optie 2: het eerste woord na de underscore bevat GEEN letter
            timestring:=z_ItemCGetFmTo(filename,1,1,'_');
            //
            //de string test
            testchar:=timestring[1];
            testval:=ord(testchar);
           // form1.caption:=inttostr(testval);
            if ((testval>64) and (testval<91)) or ((testval>96) and (testval<123)) then
              begin
                  //The second word contains a letter
                  if (timestring<>'') then
                  begin
                    Month:=z_ItemCGetFmTo(filename,1,1,'_');
                    if uppercase(copy(month,1,3))='JAN' then maand:=1;
                    if uppercase(copy(month,1,3))='FEB' then maand:=2;
                    if uppercase(copy(month,1,3))='MAR' then maand:=3;
                    if uppercase(copy(month,1,3))='APR' then maand:=4;
                    if uppercase(copy(month,1,3))='MAY' then maand:=5;
                    if uppercase(copy(month,1,3))='JUN' then maand:=6;
                    if uppercase(copy(month,1,3))='JUL' then maand:=7;
                    if uppercase(copy(month,1,3))='AUG' then maand:=8;
                    if uppercase(copy(month,1,3))='SEP' then maand:=9;
                    if uppercase(copy(month,1,3))='OCT' then maand:=10;
                    if uppercase(copy(month,1,3))='NOV' then maand:=11;
                    if uppercase(copy(month,1,3))='DEC' then maand:=12;

                    day:=z_ItemCGetFmTo(filename,2,2,'_');
                    year:=z_ItemCGetFmTo(filename,3,3,'_');
                    Hrs:=z_ItemCGetFmTo(filename,4,4,'_');
                    Min:=z_ItemCGetFmTo(filename,5,5,'_');
                    Sec:=z_ItemCGetFmTo(filename,6,6,'_');

                    wyear:=strtoint(year);
                    wmonth:=maand;
                    wday:=strtoint(day);
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=1000*secinday;
                    result:=msecinday;
                    //advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
                    //f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
                    //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(f1datetime);
                  end;
               end
             else
               begin   //The second word does not contain a letter
                  if (timestring<>'') then
                  begin
                    //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
                    Hrs:=z_ItemCGetFmTo(filename,4,4,'_');
                    Min:=z_ItemCGetFmTo(filename,5,5,'_');
                    Sec:=z_ItemCGetFmTo(filename,6,6,'_');
                    offset:=z_ItemCGetFmTo(filename,7,7,'_');
                    offset:=z_ItemCGetFmTo(offset,0,0,'-');
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=(1000*secinday)+woffset;
                    result:=msecinday;
                  end;
               end;
            end;
           if ((z_ItemCCount(filename,'_')-1)=6) then
           begin
            //optie 1: het eerste woord na de underscore bevat een letter
            //optie 2: het eerste woord na de underscore bevat GEEN letter
            timestring:=z_ItemCGetFmTo(filename,1,1,'_');
            //
            //de string test
            testchar:=timestring[1];
            testval:=ord(testchar);
           // form1.caption:=inttostr(testval);
            if ((testval>64) and (testval<91)) or ((testval>96) and (testval<123)) then
              begin
                  //The second word contains a letter
                  if (timestring<>'') then
                  begin
                    Month:=z_ItemCGetFmTo(filename,1,1,'_');
                    if uppercase(copy(month,1,3))='JAN' then maand:=1;
                    if uppercase(copy(month,1,3))='FEB' then maand:=2;
                    if uppercase(copy(month,1,3))='MAR' then maand:=3;
                    if uppercase(copy(month,1,3))='APR' then maand:=4;
                    if uppercase(copy(month,1,3))='MAY' then maand:=5;
                    if uppercase(copy(month,1,3))='JUN' then maand:=6;
                    if uppercase(copy(month,1,3))='JUL' then maand:=7;
                    if uppercase(copy(month,1,3))='AUG' then maand:=8;
                    if uppercase(copy(month,1,3))='SEP' then maand:=9;
                    if uppercase(copy(month,1,3))='OCT' then maand:=10;
                    if uppercase(copy(month,1,3))='NOV' then maand:=11;
                    if uppercase(copy(month,1,3))='DEC' then maand:=12;

                    day:=z_ItemCGetFmTo(filename,2,2,'_');
                    year:=z_ItemCGetFmTo(filename,3,3,'_');
                    Hrs:=z_ItemCGetFmTo(filename,4,4,'_');
                    Min:=z_ItemCGetFmTo(filename,5,5,'_');
                    Sec:=z_ItemCGetFmTo(filename,6,6,'_');

                    wyear:=strtoint(year);
                    wmonth:=maand;
                    wday:=strtoint(day);
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=1000*secinday;
                    result:=msecinday;
                    //advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
                    //f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
                    //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=floattostr(f1datetime);
                  end;
               end
             else
               begin   //The second word does not contain a letter
                  if (timestring<>'') then
                  begin
                    //advspreadgrid1.cells[4,advspreadGrid1.RowCount-1]:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
                    Hrs:=z_ItemCGetFmTo(filename,4,4,'_');
                    Min:=z_ItemCGetFmTo(filename,5,5,'_');
                    Sec:=z_ItemCGetFmTo(filename,6,6,'_');
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    secinday:=(3600*whrs)+(60*wmin)+wsec;
                    msecinday:=1000*secinday;
                    result:=msecinday;
                  end;
               end;
            end;

           //FORMAT: CAGE_DATE_TIME_START-STOP //selection file
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=5 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
            if (timestring<>'') then
            begin
              year:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],3,3,'_');
              month:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
              day:=(z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_'));
              Offset:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],5,5,'_');
              offset:=z_ItemCGetFmTo(offset,0,0,'-');
              //
              if uppercase(copy(month,1,3))='JAN' then maand:=1;
              if uppercase(copy(month,1,3))='FEB' then maand:=2;
              if uppercase(copy(month,1,3))='MAR' then maand:=3;
              if uppercase(copy(month,1,3))='APR' then maand:=4;
              if uppercase(copy(month,1,3))='MAY' then maand:=5;
              if uppercase(copy(month,1,3))='JUN' then maand:=6;
              if uppercase(copy(month,1,3))='JUL' then maand:=7;
              if uppercase(copy(month,1,3))='AUG' then maand:=8;
              if uppercase(copy(month,1,3))='SEP' then maand:=9;
              if uppercase(copy(month,1,3))='OCT' then maand:=10;
              if uppercase(copy(month,1,3))='NOV' then maand:=11;
              if uppercase(copy(month,1,3))='DEC' then maand:=12;
              //
              woffset:=strtoint(offset);
              wtimestring:=strtoint(timestring)+woffset;
              timestring:=inttostr(wtimestring);
              //
              result:=strtoint(timestring);
            end;
           end;


           //FORMAT: CAGE_DATE_TIME
           //TIME=MSECSFROMMIDNIGHT
           //DATE=MONTH_DAY_YEAR -- JAN_31_2005
           if (z_ItemCCount(filename,'_')-1)=4 then
           begin
            timestring:=z_ItemCGetFmTo(filename,4,4,'_');
            if (timestring<>'') then
            begin
              year:=z_ItemCGetFmTo(filename,3,3,'_');
              month:=z_ItemCGetFmTo(filename,1,1,'_');
              day:=(z_ItemCGetFmTo(filename,2,2,'_'));
              //
              if uppercase(copy(month,1,3))='JAN' then maand:=1;
              if uppercase(copy(month,1,3))='FEB' then maand:=2;
              if uppercase(copy(month,1,3))='MAR' then maand:=3;
              if uppercase(copy(month,1,3))='APR' then maand:=4;
              if uppercase(copy(month,1,3))='MAY' then maand:=5;
              if uppercase(copy(month,1,3))='JUN' then maand:=6;
              if uppercase(copy(month,1,3))='JUL' then maand:=7;
              if uppercase(copy(month,1,3))='AUG' then maand:=8;
              if uppercase(copy(month,1,3))='SEP' then maand:=9;
              if uppercase(copy(month,1,3))='OCT' then maand:=10;
              if uppercase(copy(month,1,3))='NOV' then maand:=11;
              if uppercase(copy(month,1,3))='DEC' then maand:=12;
              //
              whrs:=strtoint(timestring) div 3600000;
              wmin:=(strtoint(timestring)-(whrs*3600000)) div 60000;
              wsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)) div 1000;
              wmsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)-(wsec*1000));
              //
              result:=strtoint(timestring);
            end;
           end;
           if z_ItemCCount(filename,'_')-1=2 then
           begin
            timestring:=z_ItemCGetFmTo(filename,1,1,'_');
            datestring:=z_ItemCGetFmTo(filename,2,2,'_');
            if (timestring<>'') and (datestring <>'') then
            begin
              Hrs:=z_SMiddle(Timestring,1,2);
              Min:=z_SMiddle(Timestring,3,2);
              Sec:=z_SMiddle(Timestring,5,2);
              day:=z_SMiddle(datestring,1,2);
              month:=z_SMiddle(datestring,3,2);
              year:=z_SMiddle(datestring,5,2);
              wyear:=2000+ strtoint(year);
              wmonth:=strtoint(month);
              wday:=strtoint(day);
              whrs:=strtoint(hrs);
              wmin:=strtoint(min);
              wsec:=strtoint(sec);
              secinday:=(3600*whrs)+(60*wmin)+wsec;
              msecinday:=1000*secinday;
              //advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
              //f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
              result:=msecinday;
            end;
           end;
end;

function Tform1.filename2datetime(filename:string):Tdatetime;
var
     datmedian:smallint;
     testdata:int64array;
     rmed:integer;
     ext:string;
     sr:Tsearchrec;
     read:integer;
     minutes:extended;
     seconds:extended;
     maxfilenamelength:array[0..10] of integer;
     testwidth:integer;
     day,month,yr,hrs,min,sec,timestring,datestring:string;
     wyear,wday,wmonth,wyr,whrs,wmin,wsec,wmsec:word;
     datetime:Tdatetime;
     secinday,msecinday:int64;
     f1datetime:Tdatetime;
     testchar:char;
     testval:byte;
     maand:integer;
     workname:string;
     offset:string;
     woffset:integer;
     temptime:Tdatetime;
     omin,osec,omsec:integer;
     wtimestring:int64;
begin
           if ((z_ItemCCount(filename,'_')-1)=6) or ((z_ItemCCount(filename,'_')-1)=7) then
           begin
            //optie 1: het eerste woord na de underscore bevat een letter
            //optie 2: het eerste woord na de underscore bevat GEEN letter
            timestring:=z_ItemCGetFmTo(filename,1,1,'_');
            //
            //de string test
            testchar:=timestring[1];
            testval:=ord(testchar);
           // form1.caption:=inttostr(testval);
            if ((testval>64) and (testval<91)) or ((testval>96) and (testval<123)) then
              begin
                  //The second word contains a letter
                  if (timestring<>'') then
                  begin
                    Month:=z_ItemCGetFmTo(filename,1,1,'_');
                    if uppercase(copy(month,1,3))='JAN' then maand:=1;
                    if uppercase(copy(month,1,3))='FEB' then maand:=2;
                    if uppercase(copy(month,1,3))='MAR' then maand:=3;
                    if uppercase(copy(month,1,3))='APR' then maand:=4;
                    if uppercase(copy(month,1,3))='MAY' then maand:=5;
                    if uppercase(copy(month,1,3))='JUN' then maand:=6;
                    if uppercase(copy(month,1,3))='JUL' then maand:=7;
                    if uppercase(copy(month,1,3))='AUG' then maand:=8;
                    if uppercase(copy(month,1,3))='SEP' then maand:=9;
                    if uppercase(copy(month,1,3))='OCT' then maand:=10;
                    if uppercase(copy(month,1,3))='NOV' then maand:=11;
                    if uppercase(copy(month,1,3))='DEC' then maand:=12;

                    workname:=z_ItemCGetFmTo(filename,0,0,'.');
                    day:=z_ItemCGetFmTo(workname,2,2,'_');
                    year:=z_ItemCGetFmTo(workname,3,3,'_');
                    Hrs:=z_ItemCGetFmTo(workname,4,4,'_');
                    Min:=z_ItemCGetFmTo(workname,5,5,'_');
                    Sec:=z_ItemCGetFmTo(workname,6,6,'_');

                    wyear:=strtoint(year);
                    wmonth:=maand;
                    wday:=strtoint(day);
                    whrs:=strtoint(hrs);
                    wmin:=strtoint(min);
                    wsec:=strtoint(sec);
                    result:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
                  end;
               end
             else
               begin   //The second word does not contain a letter
                  if (timestring<>'') then
                  begin
                    offset:=z_ItemCGetFmTo(filename,7,7,'_');
                    offset:=z_ItemCGetFmTo(offset,0,0,'-');
                    result:=strtofloat(z_ItemCGetFmTo(filename,1,1,'_'));
                    if offset<>'' then
                    begin
                      woffset:=strtoint(offset);
                      omin:=woffset div 60000;
                      osec:=(woffset-(omin*60000)) div 1000;
                      omsec:=woffset-(omin*60000)-(osec*1000);
                      temptime:=encodetime(0,omin,osec,omsec);
                      result:=strtofloat(z_ItemCGetFmTo(filename,1,1,'_'))+temptime;
                    end;
                  end;
               end;
            end;

           //FORMAT: CAGE_DATE_TIME_START-STOP //selection file
           if (z_ItemCCount(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],'_')-1)=5 then
           begin
            timestring:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],4,4,'_');
            if (timestring<>'') then
            begin
              year:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],3,3,'_');
              month:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],1,1,'_');
              day:=(z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],2,2,'_'));
              Offset:=z_ItemCGetFmTo(advspreadGrid1.Cells[0, advspreadGrid1.RowCount-1],5,5,'_');
              offset:=z_ItemCGetFmTo(offset,0,0,'-');
              //
              if uppercase(copy(month,1,3))='JAN' then maand:=1;
              if uppercase(copy(month,1,3))='FEB' then maand:=2;
              if uppercase(copy(month,1,3))='MAR' then maand:=3;
              if uppercase(copy(month,1,3))='APR' then maand:=4;
              if uppercase(copy(month,1,3))='MAY' then maand:=5;
              if uppercase(copy(month,1,3))='JUN' then maand:=6;
              if uppercase(copy(month,1,3))='JUL' then maand:=7;
              if uppercase(copy(month,1,3))='AUG' then maand:=8;
              if uppercase(copy(month,1,3))='SEP' then maand:=9;
              if uppercase(copy(month,1,3))='OCT' then maand:=10;
              if uppercase(copy(month,1,3))='NOV' then maand:=11;
              if uppercase(copy(month,1,3))='DEC' then maand:=12;
              //
              woffset:=strtoint(offset);
              wtimestring:=strtoint(timestring)+woffset;
              timestring:=inttostr(wtimestring);
              whrs:=strtoint(timestring) div 3600000;
              wmin:=(strtoint(timestring)-(whrs*3600000)) div 60000;
              wsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)) div 1000;
              wmsec:=(strtoint(timestring)-(whrs*3600000)-(wmin*60000)-(wsec*1000));
              result:=encodedatetime(strtoint(year),maand,strtoint(day),whrs,wmin,wsec,wmsec);
            end;
           end;

           //FORMAT: CAGE_DATE_TIME
           //TIME=MSECSFROMMIDNIGHT
           //DATE=MONTH_DAY_YEAR -- JAN_31_2005
           if (z_ItemCCount(filename,'_')-1)=4 then
           begin
            timestring:=z_ItemCGetFmTo(filename,4,4,'_');
            if (timestring<>'') then
            begin
              year:=z_ItemCGetFmTo(filename,3,3,'_');
              month:=z_ItemCGetFmTo(filename,1,1,'_');
              day:=(z_ItemCGetFmTo(filename,2,2,'_'));
              if uppercase(copy(month,1,3))='JAN' then maand:=1;
              if uppercase(copy(month,1,3))='FEB' then maand:=2;
              if uppercase(copy(month,1,3))='MAR' then maand:=3;
              if uppercase(copy(month,1,3))='APR' then maand:=4;
              if uppercase(copy(month,1,3))='MAY' then maand:=5;
              if uppercase(copy(month,1,3))='JUN' then maand:=6;
              if uppercase(copy(month,1,3))='JUL' then maand:=7;
              if uppercase(copy(month,1,3))='AUG' then maand:=8;
              if uppercase(copy(month,1,3))='SEP' then maand:=9;
              if uppercase(copy(month,1,3))='OCT' then maand:=10;
              if uppercase(copy(month,1,3))='NOV' then maand:=11;
              if uppercase(copy(month,1,3))='DEC' then maand:=12;
              wyear:=strtoint(year);
              wmonth:=maand;
              wday:=strtoint(day);
              msecinday:=strtoint(z_ItemCGetFmTo(timestring,0,0,'.'));
              whrs:=msecinday div 3600000;
              wmin:=(msecinday-(whrs*3600000))div 60000;
              wsec:=(msecinday-(whrs*3600000)-(wmin*60000)) div 1000;
              wmsec:=(msecinday-(whrs*3600000)-(wmin*60000)-(wsec*1000));
              result:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,wmsec);
            end;
           end;
           if z_ItemCCount(filename,'_')-1=2 then
           begin
            timestring:=z_ItemCGetFmTo(filename,1,1,'_');
            datestring:=z_ItemCGetFmTo(filename,2,2,'_');
            if (timestring<>'') and (datestring <>'') then
            begin
              Hrs:=z_SMiddle(Timestring,1,2);
              Min:=z_SMiddle(Timestring,3,2);
              Sec:=z_SMiddle(Timestring,5,2);
              day:=z_SMiddle(datestring,1,2);
              month:=z_SMiddle(datestring,3,2);
              year:=z_SMiddle(datestring,5,2);
              wyear:=2000+ strtoint(year);
              wmonth:=strtoint(month);
              wday:=strtoint(day);
              whrs:=strtoint(hrs);
              wmin:=strtoint(min);
              wsec:=strtoint(sec);
              secinday:=(3600*whrs)+(60*wmin)+wsec;
              msecinday:=1000*secinday;
              //advspreadgrid1.cells[6,advspreadGrid1.RowCount-1]:=inttostr(msecinday);
              f1datetime:=encodedatetime(wyear,wmonth,wday,whrs,wmin,wsec,0);
              result:=f1Datetime;
            end;
           end;
end;

procedure TForm1.Button88Click(Sender: TObject);
var i,j:integer;
    target:integer;
begin
 if not floatdat then
 begin
   target:=trunc(rxspinedit69.value);
   memo5.color:=clred;
   memo5.Lines.add('Deleting '+inttostr(target));memo5.Update;
   for i:=1 to lcount do
   begin
     if (kmeans1.iwork[i-1]=target) then
     begin
        kmeans1.iwork[i-1]:=kmeans1.numclusters+1;
     end;
   end;
   memo5.color:=clwhite;
   memo5.Lines.add('DONE');memo5.Update;
 end;

 if floatdat then
 begin
   target:=trunc(rxspinedit69.value);
   memo5.color:=clred;
   memo5.Lines.add('Deleting '+inttostr(target));memo5.Update;
   for i:=1 to lcount do
   begin
     if (kmeans1F.iwork[i-1]=target) then
     begin
        kmeans1F.iwork[i-1]:=kmeans1F.numclusters+1;
     end;
   end;
   memo5.color:=clwhite;
   memo5.Lines.add('DONE');memo5.Update;
   button86click(self);
 end;
end;

procedure TForm1.Button89Click(Sender: TObject);
var r1,r2,r3:integer;
    sum:array[0..232] of integer;
    i,p,x,y,k:integer;
begin
 if not floatdat then
 begin
  r1:=235;
  r2:=specreclen;
  For i:=1 to Lcount do
  begin
      //getimgspec
      p:=idbdata[i].offset+2;
      for y:=0 to idbdata[i].height-1 do sum[y]:=0;
      for x:=0 to idbdata[i].width-1 do
       for y:=0 to idbdata[i].height-1 do
       begin
          sum[y]:=sum[y]+idbimg[p];
          inc(p);
       end;

      for k:=3 to r1 do
      begin
          dumdata[i].wavform[k-3]:=sum[k-3];
      end;
      for k:=r1 to r2 do
      begin
          dumdata[i].wavform[k-3]:=0;
      end;
      for k:=specreclen to specreclen+10 do
      begin
          //dumdata[i].wavform[k]:=5*idbdata[i].width;
          dumdata[i].wavform[k]:=0;
      end;
  end;
 end;

 if floatdat then
 begin
  r1:=235;
  r2:=specreclen;
  For i:=1 to Lcount do
  begin
      //getimgspec
      p:=idbdata[i].offset+2;
      for y:=0 to idbdata[i].height-1 do sum[y]:=0;
      for x:=0 to idbdata[i].width-1 do
       for y:=0 to idbdata[i].height-1 do
       begin
          sum[y]:=sum[y]+idbimg[p];
          inc(p);
       end;

      for k:=3 to r1 do
      begin
          dumdataF[i].wavformF[k-3]:=sum[k-3];
      end;
      for k:=r1 to r2 do
      begin
          dumdataF[i].wavformF[k-3]:=0;
      end;
      for k:=specreclen to specreclen+10 do
      begin
          //dumdata[i].wavform[k]:=5*idbdata[i].width;
          dumdataF[i].wavformF[k]:=0;
      end;
  end;
 end;

end;

procedure TForm1.CheckBox84Click(Sender: TObject);
begin
  checkbox85.Checked:=NOT checkbox84.Checked;
end;

procedure TForm1.CheckBox85Click(Sender: TObject);
begin
  checkbox84.Checked:=NOT checkbox85.Checked;
end;

procedure TForm1.CheckBox91Click(Sender: TObject);
begin
 /// if checkbox91.checked then showmessage('This does not work for SAP files (yet)');
end;

procedure TForm1.CheckBox97Click(Sender: TObject);
begin
      label119.Enabled:=true;
end;

procedure TForm1.CheckBox98Click(Sender: TObject);
begin
      label119.Enabled:=true;
end;

procedure TForm1.Button90Click(Sender: TObject);
var fromcluster,tocluster,i:integer;
begin
 if not floatdat then
 begin
   if rxspinedit72.value>rxspinedit73.value then
   begin
     fromcluster:=trunc(rxspinedit72.value);
     tocluster:=trunc(rxspinedit73.value);
   end;
   if rxspinedit72.value<rxspinedit73.value then
   begin
     fromcluster:=trunc(rxspinedit73.value);
     tocluster:=trunc(rxspinedit72.value);
   end;
   if not (rxspinedit72.value=rxspinedit73.value) then
   begin
    memo5.color:=clred;
    memo5.Lines.add('Merging '+inttostr(Fromcluster)+' and '+inttostr(tocluster));memo5.Update;
    for i:=1 to lcount do
    begin
     if (kmeans1.iwork[i-1]=fromcluster) then
     begin
        kmeans1.iwork[i-1]:=tocluster;
     end;
    end;
   end;
   memo5.color:=clwhite;
   memo5.Lines.add('DONE');memo5.Update;
   button86click(self);
 end;

 if floatdat then
 begin
   if rxspinedit72.value>rxspinedit73.value then
   begin
     fromcluster:=trunc(rxspinedit72.value);
     tocluster:=trunc(rxspinedit73.value);
   end;
   if rxspinedit72.value<rxspinedit73.value then
   begin
     fromcluster:=trunc(rxspinedit73.value);
     tocluster:=trunc(rxspinedit72.value);
   end;
   if not (rxspinedit72.value=rxspinedit73.value) then
   begin
    memo5.color:=clred;
    memo5.Lines.add('Merging '+inttostr(Fromcluster)+' and '+inttostr(tocluster));memo5.Update;
    for i:=1 to lcount do
    begin
     if (kmeans1F.iwork[i-1]=fromcluster) then
     begin
        kmeans1F.iwork[i-1]:=tocluster;
     end;
    end;
   end;
   memo5.color:=clwhite;
   memo5.Lines.add('DONE');memo5.Update;
   button86click(self);
 end;
end;

procedure TForm1.Button92Click(Sender: TObject);
var i:integer;
begin

  form30.advspreadgrid1.clear;
  form30.advspreadgrid1.rowcount:=0;

  imgview326.Bitmap.SetSize(0,0);
  imgview325.bitmap.setsize(0,0);

  //for i:=0 to high(extarea)-1 do
  //begin
  //  if extarea[i]<>nil then setlength(extarea[i],0);
  //end;
  //setlength(extarea,0);
  setlength(extareatrack,0);

end;

procedure TForm1.RxSpinEdit64Change(Sender: TObject);
begin
    rfjChart12click(Self);
end;

procedure TForm1.Button87Click(Sender: TObject);
var i:integer;
    checkstate:boolean;
begin
  movie:=true;
  checkstate:=checkbox83.checked;
  checkbox83.checked:=true;
  //at least once
  for i:=1 to lcount do
  begin
      if selection[i] then rxspinedit60.value:=i;
      image321.Update;
      sleep(20);
  end;
  //and if needed, looping
  while checkbox87.Checked do
  for i:=1 to lcount do
  begin
      if selection[i] then rxspinedit60.value:=i;
      image321.Update;
      sleep(20);
  end;
  checkbox83.checked:=checkstate;
  movie:=false;
end;


procedure TForm1.RxSpinEdit71Change(Sender: TObject);
var i, targetbmp:integer;
begin
   leftmousebutton:=false;
   rightmousebutton:=false;

   if usedisk then
   begin
    for i:=0 to numclusters do
    begin
       showbmp[i].SetSize(0,0);
    end;
    targetbmp:=trunc(rxspinedit71.value); //rfj
    showbmp[targetbmp].LoadFromFile(filepath+'\cluster_'+inttostr(targetbmp)+'.bmp');  //rfj
    imgview324.bitmap.Assign(showbmp[targetbmp]); //rfj
   end;
   if usemem then imgview324.bitmap.Assign(showbmp[trunc(rxspinedit71.value)]); //rfj
end;

procedure TForm1.ImgView324MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var x1,y1,x2,y2:integer;
    cluster,k:integer;
    item:integer;
begin
   cluster:=trunc(rxspinedit71.value);
   if button=mbleft then
   begin
    leftmousebutton:=true;
    leftclickitem:=currentitem;
    item:=area[cluster,currentitem].item;
   end;
   if button=mbright then
   begin
     rightmousebutton:=true;
     rightclickitem:=currentitem;
     item:=area[cluster,currentitem].item;
     {
     currentx1:=area[cluster,item].topleft.x;
     currenty1:=area[cluster,item].topleft.y;
     currentx2:=area[cluster,item].bottomright.x;
     currenty2:=area[cluster,item].bottomright.y;
     kmeans1.iwork[item-1]:=trunc(rxspinedit67.value);
     showbmp[cluster].LineS(currentx1,currenty1,currentx2,currenty2,clred32);
     showbmp[cluster].LineS(currentx2,currenty1,currentx1,currenty2,clred32);
     }
   end;
   if leftmousebutton and rightmousebutton then
   begin
    for k:=leftclickitem to rightclickitem do
    begin
      //if kmeans1.iwork[k-1]=cluster then
      begin
       item:=area[cluster,k].item;
       currentx1:=area[cluster,k].topleft.x;
       currenty1:=area[cluster,k].topleft.y;
       currentx2:=area[cluster,k].bottomright.x;
       currenty2:=area[cluster,k].bottomright.y;

       if not floatdat then kmeans1.iwork[item-1]:=trunc(rxspinedit67.value);
       if floatdat then kmeans1F.iwork[item-1]:=trunc(rxspinedit67.value);
       showbmp[cluster].LineS(currentx1,currenty1,currentx2,currenty2,clred32);
       showbmp[cluster].LineS(currentx2,currenty1,currentx1,currenty2,clred32);
       //RxSpinEdit71Change(self);
      end;
    end;
    imgview324.bitmap.Assign(showbmp[trunc(rxspinedit71.value)]);
    imgview324.Update;
    leftmousebutton:=false;
    rightmousebutton:=false;
   end;
end;

procedure TForm1.CheckBox81Click(Sender: TObject);
begin
  button84.Enabled:=not checkbox81.checked;
end;

procedure TForm1.RxSpinEdit76Change(Sender: TObject);
begin
 slide[echannel].Position:=(slide[echannel].max-trunc(rxspinedit76.value));
end;

procedure TForm1.RxSpinEdit77Change(Sender: TObject);
begin
    imgview325.Bitmap.LoadFromFile(inttostr(trunc(rxspinedit77.value))+'.bmp');
end;

{
procedure screencapture;
var
  B: TBitmap;
  AFormat: Word;
  AData: THandle;
  APalette: HPALETTE;
begin
   b := TBitmap.Create;
   ScreenShot(B);
   Self.Image1.Picture.Bitmap.Assign(B);
   Self.Image1.Picture.Bitmap.SaveToClipboardFormat(AFormat, AData, APalette);
   ClipBoard.SetAsHandle(AFormat, AData);
   B.Free;
end;
}

{
# Wiener entropy, by Gabriel J.L. Beckers
# developed in Praat version 4.2.06
# 2004-07-03

# Wiener entropy is a measure of spectral flatness of a sound.
# It is defined as the ratio of a power spectrum's geometric mean and
# its arithmetic mean. It is scaled to a log scale, which ranges from
# 0 (power spectrum is flat) to minus infinity (power spectrum is
# infinitely narrow).

# Usage: select a sound object and run.

frame_duration = 0.01
time_step = 0.004
start_frequency = 300
end_frequency = 10000

clearinfo

sound_id = selected("Sound")
sound_name$ = selected$("Sound")

sampling_period = Get sampling period

duration = Get total duration
start_time = Get starting time
number_of_steps = floor((duration-frame_duration)/time_step) + 1

sum_wiener_entropy = 0
for frame_no from 1 to number_of_steps
	Extract part... start_time start_time+frame_duration Gaussian1 1 yes
	sound_frame_id = selected("Sound")
	#printline 'start_time'
	start_time = start_time + time_step

	To Spectrum (dft)
	spectrum_id = selected("Spectrum")
	Rename... Spectrum
	number_of_bins = Get number of bins

	highest_frequency = Get highest frequency
	if highest_frequency < end_frequency
		end_frequency = highest_frequency
	endif
	start_bin = Get bin number from frequency... 'start_frequency'
	end_bin = Get bin number from frequency... 'end_frequency'
	start_bin = round(start_bin)
	end_bin = round(end_bin)
	actual_start_frequency = Get frequency from bin number... 'start_bin'
	actual_end_frequency = Get frequency from bin number... 'end_bin'
	number_of_band_bins = end_bin - start_bin + 1

	Create simple Matrix... power_spectrum 1 'number_of_band_bins' 0
	power_spectrum_id = selected("Matrix")
	Formula... ((Spectrum_Spectrum [1,col]/sampling_period)^2 + (Spectrum_Spectrum [2,col]/sampling_period)^2)

	sum_power_spectrum = 0
	for bin from start_bin to end_bin
		sum_power_spectrum += Matrix_power_spectrum[1,bin]
	endfor
	arithmetic_mean = sum_power_spectrum/number_of_bins

	Create simple Matrix... ln_power_spectrum 1 'number_of_band_bins' 0
	ln_power_spectrum_id = selected("Matrix")
	Formula... ln(Matrix_power_spectrum[])

	sum_ln_power_spectrum = 0
	for bin from start_bin to end_bin
		sum_ln_power_spectrum += Matrix_ln_power_spectrum[1,bin]
	endfor
	geometric_mean = exp(sum_ln_power_spectrum/number_of_band_bins)

	frame_wiener_entropy = ln(geometric_mean/arithmetic_mean)
	#printline wiener entropy frame 'frame_no': 'frame_wiener_entropy'
	sum_wiener_entropy += frame_wiener_entropy

	select 'spectrum_id'
	plus 'power_spectrum_id'
	plus 'ln_power_spectrum_id'
	plus 'sound_frame_id'
	Remove
	select 'sound_id'

endfor

wiener_entropy = sum_wiener_entropy/number_of_steps
printline mean wiener entropy: 'wiener_entropy'
}

end.


