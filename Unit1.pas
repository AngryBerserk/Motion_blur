unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;
const N=500;
type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    BlurFrame:TBitmap;
    MX,
    MY:Word;
    particles:array [1..N] of Record
                        Coord:TPoint;
                        Speed:Word;
                        Size:Byte;
              End;
    Blur_P:Array [1..2000] of PByteArray;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
 var x:Word;
begin
BlurFrame:=TBitmap.Create;
BlurFrame.Width:=ClientWidth;
BlurFrame.Height:=ClientHeight+160;
BlurFrame.PixelFormat:=pf24bit;
BlurFrame.Canvas.Brush.Color:=clWhite;
BlurFrame.Canvas.Pen.Color:=clWhite;
For x:=1 to ClientHeight+160-1 Do Begin
 Blur_P[x]:=BlurFrame.ScanLine[x] ;
End;
For x:=1 to N Do Begin
  Particles[x].Coord.x:=Random(ClientWidth);
  Particles[x].Coord.y:=Random(ClientHeight);
  Particles[x].Speed:=1+Random(5);
  Particles[x].Size :=1+Random(80);
End;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var z:Word;

 Procedure Fade_Frame;
  var p:PByteArray;x,y:Word;
 Begin
  For y:=1 to ClientHeight+160-1 Do Begin
      P:=Blur_P[y];
      For x:=1 to (ClientWidth-1)*3 Do
       If P[x]>10 Then P[x]:=P[x]-10 Else P[x]:=0;
      End
 End;

begin
Fade_Frame;
For z:=1 to N Do Begin
  Particles[z].Coord.Y:=Particles[z].Coord.Y+Particles[z].Speed;
  If particles[z].Coord.Y>ClientHeight+160 Then Particles[z].Coord.Y:=0;
  BlurFrame.Canvas.Ellipse(Particles[z].Coord.X,Particles[z].Coord.Y,Particles[z].Coord.X+Particles[z].Size,Particles[z].Coord.Y+Particles[z].Size)
End;
Canvas.Draw(0,-80,BlurFrame);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
MX:=X;
MY:=Y;
end;

end.
