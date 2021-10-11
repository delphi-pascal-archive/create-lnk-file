unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComObj, SHLObj, ActiveX;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
 IdList: PITEMIDLIST;
 ShortCutPath: string;
 ShellLink: IShellLink;
 Path: array[0..MAX_PATH] of Char;
begin
 if SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, IdList)=NOERROR
 then
  begin
   SHGetPathFromIDList(IdList, Path); // Chemin du bureau de Windows
   // Création du raccourci
   ShellLink:=CreateComObject(CLSID_ShellLink) as IShellLink;
   ShellLink.SetDescription('Test LNK');
   ShellLink.SetPath(PChar(Application.ExeName));
   ShellLink.SetShowCmd(SW_SHOW);
   ShortCutPath:=string(Path)+'\'+'Test link to file'+'.LNK';
   (ShellLink as IpersistFile).Save(StringToOleStr(ShortCutPath), true);
  end;
end;

end.
