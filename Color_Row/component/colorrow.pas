unit ColorRow;
{
ColorRow component, version 1.0, 29.12.2007
Written by Roman Barlos
� 2007 LogicArt Software
All rights reserved
}

interface

uses
  SysUtils, Classes, Controls, Graphics, messages;

type

  PPoint = ^TPoint;
  TPoint = packed record
    X: Longint;
    Y: Longint;
  end;

  PRect = ^TRect;
  TRect = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: Longint);
      1: (TopLeft, BottomRight: TPoint);
  end;

  TIndexInt = 1..10;  // �������� �������� ���������

  TCrossStyle =(csBlack, csBlackWhite,csInvert); // ����� �������� ����������
  {
  csBlack - ������ ������
  csBlackWhite - ������ ������, ���� ���������� ���� �� ������, � ��������� ������ - �����
  csInvert - ���� ���������� ����� ���������������� ����������� ����� (�� ���� ����� [$ffffff - ���������� ����])
  }

  TColorRow = class(TGraphicControl) // ����� ����������
  private
    { Private declarations }
    pcolor, bcolor: TColor; // ��������� �������� ����� ����� (PenColor) b ����� �������� (BrushColor)
    fAbout: ShortString;  // read-only ������ "� ����������", ���������������� �������������
    fColors: array [1..10] of TColor; // ������ ������
    fNoBorder: boolean; // ��� ������?
    fItemIndex: TIndexInt; // ������ ��������
    fCrossStyle: TCrossStyle; // ����� �������� ����������
    fSelected: TColor; // ���������� ����
    {���������}
    procedure SetColor(index:Integer; value:TColor); // ������ ���� index-��������
    procedure PaintCell(index:Integer);  // ������ index-������
    procedure PushColors; // ������ ��������� �������� ��� �������
    procedure PopColors;  // ������ ������� �������� ��� ���������
    procedure SetBColor(color:TColor); // ������ ���� ��������
    procedure SetPColor(color:TColor); // ������ ���� �����
    procedure SetItemIndex(value:TIndexInt); // ������ ������� ������
    procedure SetCrossStyle(value:TCrossStyle); // ������ ����� �������� ����������
    procedure PaintCross(index:Integer);  // ������ ����������
    procedure SetNoBorder(value:Boolean); // ������ ��� ������
    procedure DrawLine(x1,y1,x2,y2:Integer); overload; // ������ �����
    procedure DrawLine(xy1, xy2:TPoint); overload; // ������ �����
    {�������}
    function GetColor(index:Integer):TColor; // ���������� ���� index-��������
    function CellWidth: Integer; // ���������� ������ ������
    function CellHeight: Integer; // ���������� ������ ������
    function ItemAt(x:Integer):Integer; // ���������� ������ �������� �� ���������� X
    function GetCrossColor(index:Integer):TColor; // ���������� ���� ���������� � ������������ �� ������
    function GetSelected:TColor; // ���������� ������� ����
    function GetCellRect(index:Integer):TRect; // ���������� ������������� ������� index-������

  protected
    { Protected declarations }
    procedure Paint; override; // ������ ���������
    procedure WMClick(var msg: TWMLbuttondown); message wm_lbuttondown;  // ������������� ������� ����� ������ ����
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override; // ����������� ����������
    destructor Destroy; override; // ���������� ����������
    procedure Repaint; override;  // ��������� ���������������
  published
    { Published declarations }
    property About: ShortString read fAbout;
    property Selected:TColor read fSelected;
    property CrossStyle: TCrossStyle read fCrossStyle write SetCrossStyle;
    property NoBorder: boolean read fNoBorder write SetNoBorder;
    property ItemIndex: TIndexInt read fItemIndex write SetItemIndex;
    property Color1: TColor index 1 read GetColor write SetColor;
    property Color2: TColor index 2 read GetColor write SetColor;
    property Color3: TColor index 3 read GetColor write SetColor;
    property Color4: TColor index 4 read GetColor write SetColor;
    property Color5: TColor index 5 read GetColor write SetColor;
    property Color6: TColor index 6 read GetColor write SetColor;
    property Color7: TColor index 7 read GetColor write SetColor;
    property Color8: TColor index 8 read GetColor write SetColor;
    property Color9: TColor index 9 read GetColor write SetColor;
    property Color10: TColor index 10 read GetColor write SetColor;

    property onClick;
  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('My components', [TColorRow]);
end;


{ TColorRow }

constructor TColorRow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fAbout := 'Copyright (c) 2007 LogicArt Software';
  Pushcolors;
  if itemindex < 1 then itemindex := 1;
  fSelected := GetSelected();
end;

destructor TColorRow.Destroy;
begin

  inherited Destroy;
end;

procedure TColorRow.PushColors;
begin
  pcolor := Canvas.Pen.Color;
  bcolor := Canvas.Brush.Color;
end;

procedure TColorRow.PopColors;
begin
  Canvas.Pen.Color := pcolor;
  Canvas.Brush.Color := bcolor;
end;

function TColorRow.GetColor(index: Integer): TColor;
begin
  result := fColors[index];
end;

procedure TColorRow.Paint;
var i:Integer;
begin
  inherited;
  Canvas.Rectangle(0,0,cellwidth*10-10,cellheight);
  for i:=1 to 10 do PaintCell(i);
end;


function TColorRow.GetCrossColor(index:Integer):TColor;
begin
  result := clBlack;
  case CrossStyle of
  csBlack: result := clBlack;
  csBlackWhite: if fColors[index] <> clBlack then result := clBlack else result := clWhite;
  csInvert: result := $ffffff - fcolors[index];
  end;
end;

procedure TColorRow.PaintCell(index: Integer);
var r:TRect;
begin
   PushColors;
   r := GetCellRect(index);
   SetBcolor(fcolors[index]);
   if (noborder)  then SetPcolor(fcolors[index]);
   Canvas.Rectangle(r.TopLeft.X,r.TopLeft.Y,r.BottomRight.X,r.BottomRight.Y);
   if index = itemindex then
   begin
   Setpcolor(GetCrossColor(index));
 {  Canvas.MoveTo((index-1)*cellwidth-(index-1)+(CellWidth div 2),(cellheight div 2)-(cellheight div 3));
   Canvas.LineTo((index-1)*cellwidth-(index-1)+(CellWidth div 2),(cellheight div 2)+(cellheight div 3));

   Canvas.MoveTo((index-1)*cellwidth-(index-1)+(CellWidth div 2)+(cellwidth div 3),(cellheight div 2));
   Canvas.LineTo((index-1)*cellwidth-(index-1)+(CellWidth div 2)-(cellwidth div 3),(cellheight div 2));
   }
   PaintCross(index);
   end;
   PopColors;
end;

procedure TColorRow.Repaint;
begin
  inherited;
  Paint;
end;

procedure TColorRow.SetColor(index: Integer; value: TColor);
begin
  fColors[index] := value;
  if self.Parent <> nil then PaintCell(index);
end;

procedure TColorRow.SetBColor(color: TColor);
begin
  Canvas.Brush.Color := color;
end;

procedure TColorRow.SetPColor(color: TColor);
begin
  Canvas.Pen.Color := color;
end;



function TColorRow.CellHeight: Integer;
begin
  result := height ;
end;

function TColorRow.CellWidth: Integer;
begin
  result := (width) div 10;
end;



procedure TColorRow.WMClick(var msg: TWMLbuttondown);
var newindex, oldindex:Integer;
begin
   newindex := ItemAt(msg.XPos);
   if (itemindex <> newindex) and (newindex <> 0) then
   begin
   oldindex := itemindex;
   itemindex :=  newindex;
   PaintCell(oldindex);
   PaintCell(newindex);
   fSelected := GetSelected();
   end;
   if Assigned(onClick) then onClick(self);
end;

function TColorRow.ItemAt(x: Integer): Integer;
begin
  result := (x div (cellwidth-1))+1;
  if (result > 10) or (result < 1) then result :=0; 
end;


function TColorRow.GetSelected: TColor;
begin
  result := fColors[itemindex];
end;

procedure TColorRow.SetNoBorder(value: Boolean);
begin
  if NoBorder <> Value then
  begin
  fNoBorder := Value;
  if self.Parent <> nil then Repaint;
  end;
end;

procedure TColorRow.SetItemIndex(value: TIndexInt);
var oldindex: Integer;
begin
   if (fItemindex <> value) and (value>0) and (value<11) then
   begin
   oldindex := fItemindex;
   fItemindex :=  value;
   if self.Parent <> nil then
   begin
   PaintCell(oldindex);
   PaintCell(fItemindex);
   end;

   fSelected := GetSelected();
   end;
end;

procedure TColorRow.SetCrossStyle(value: TCrossStyle);
begin
  if fCrossStyle <> value then
  begin
  fCrossstyle := value;
  if self.Parent <> nil then Repaint;
  end;
end;

function TColorRow.GetCellRect(index: Integer): TRect;
begin
 // Canvas.Rectangle((index-1)*cellwidth-(index-1),0, (index)*cellwidth-(index-1),cellheight);
  result.TopLeft.X := (index-1)*cellwidth-(index-1);
  result.TopLeft.Y := 0;
  result.BottomRight.X := (index)*cellwidth-(index-1);
  result.BottomRight.Y := cellheight;
end;

procedure TColorRow.PaintCross(index: Integer);
var r:TRect;
osx,osy:Integer;
begin
  r := GetCellRect(index);
  osx := cellwidth div 3;
  osy := cellheight div 3;
  canvas.Pen.Width :=2;
  DrawLine(r.Left+osx,r.Top+osy,r.Right-osx,r.Bottom-osy);
  DrawLine(r.Right-osx,r.Top+osy,r.Left+osx,r.Bottom-osy);
  canvas.Pen.Width :=1;
end;

procedure TColorRow.DrawLine(x1, y1, x2, y2:Integer);
begin
  with Canvas do
  begin
  MoveTo(x1,y1);
  LineTo(x2,y2);
  end;
end;

procedure TColorRow.DrawLine(xy1, xy2: TPoint);
begin
   with Canvas do
  begin
  MoveTo(xy1.X,xy1.Y);
  LineTo(xy2.X,xy2.Y);
  end;
end;

end.
