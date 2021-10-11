unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ColorRow;

type
  TForm1 = class(TForm)
    ColorRow1: TColorRow;
    ColorRow2: TColorRow;
    procedure ColorRow1Click(Sender: TObject);
    procedure ColorRow2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ColorRow1Click(Sender: TObject);
begin
 Color:=ColorRow1.Selected;
end;

procedure TForm1.ColorRow2Click(Sender: TObject);
begin
 Color:=ColorRow2.Selected;
end;

end.
