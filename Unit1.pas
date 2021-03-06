unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, math, ClipBrd;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    StaticText1: TStaticText;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    StaticText2: TStaticText;
    Label4: TLabel;
    Label5: TLabel;
    StaticText3: TStaticText;
    Button2: TButton;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StaticText2Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses StrUtils;

{$R *.dfm}

function IntToBin(D:Extended):String;
var
 s,s2:string;
 c,d2:Extended;
 i:integer;
begin
 s:=''; d2:=trunc(abs(D));
 repeat
  c:=d2/2;
  if frac(c)>0 then s:=s+'1' else s:=s+'0';
  d2:=trunc(c);
 until d2=0;
 s2:='';
 for i:=Length(s) downto 1 do s2:=s2+s[i];
 if length(s2)>1 then if s2[1]='0' then s2:=copy(s2,2,length(s2));
 result:=s2;
end; //function TruncToBin

function FracToBin(D:Extended):String;
var
 s:string;
 c,d2:Extended;
begin
 s:=''; d2:=frac(abs(d));
 while (D2>0) and (Length(s)<StrToInt(Form1.Edit2.Text)-13) do begin
  c:=D2*2;
  if Trunc(c)=1 then s:=s+'1' else s:=s+'0';
  D2:=Frac(c);
 end;
 Result:=s;
end; //function FracToBin

function space(s:string;i:integer):string;
var
 k:integer;
 s2:string;
begin
 k:=0; s2:='';
 for i:=1 to length(s) do begin
  if k=8 then begin
   k:=0;
   s2:=s2+' '+s[i];
  end else s2:=s2+s[i];
  inc(k);
 end; //for i
 result:=s2;
end; //function space

function BinToInt(s:string):Integer;
var
 i:integer;
 j:Extended;
 s2:string;
begin
 j:=0;
 for i:=Length(s) downto 1 do s2:=s2+s[i];
 for i:=Length(s2) downto 1 do
  j:=j+(StrToInt(s2[i])*power(2,(i-1)));
 result:=Round(j);
end; //function BinToInt

function BinToFrac(k:integer;s:string):Extended;
var
 i:integer;
 j:Extended;
begin
 j:=0;
 for i:=1 to length(s) do j:=j+(StrToInt(s[i])*power(2,-i));

 result:=k+j;
end; //function BinToFrac

function BinToFloat(s:string):String;
var
 ex,mantissa,trc,frc:string;
 ex2,trc2:integer;
 frc2:Extended;
begin
 ex:=copy(s,2,7);
 ex2:=BinToInt(ex)-64;
 mantissa:=copy(s,9,length(s));
 trc:=copy(mantissa,1,ex2);
 trc2:=BinToInt(trc);
 frc:=copy(mantissa,ex2+1,length(mantissa));
 frc2:=BinToFrac(trc2,frc);
 result:=IfThen(s[1]='1','-','')+FloatToStr(frc2);
end; //function BinToFloat

procedure TForm1.Button1Click(Sender: TObject);
var
 trc,frc,ex,s:String;
begin
 trc:=IntToBin(StrToFloat(Edit1.Text));
 frc:=FracToBin(StrToFloat(Edit1.Text));
 StaticText1.Caption:=trc+IfThen(trim(frc)<>'','.','')+frc;
 Label3.Caption:='Математическое представление: '+IntToStr(Length(StaticText1.Caption))+' симв';

 if StrToFloat(Edit1.Text)>=0 then s:='0' else s:='1';
 ex:=IntToBin(Length(trc)+64);
 StaticText2.Caption:=s+ex+' '+space(trc+frc,8);
 Label4.Caption:='Машинное представление: '+IntToStr(Length(s+ex+trc+frc))+' бит';

 StaticText3.Caption:=BinToFloat(s+ex+trc+frc);
end;

procedure TForm1.Button2Click(Sender: TObject);
var R:Extended;
 begin
  R:=1;
  while 1+R/2>1 do
   R:=R/2;
  Label6.Caption:=FloatToStr(R)
end;

procedure TForm1.StaticText2Click(Sender: TObject);
begin
 Clipboard.SetTextBuf(PChar(StaticText2.Caption));
end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin
 Clipboard.SetTextBuf(PChar(StaticText1.Caption));
end;

end.
