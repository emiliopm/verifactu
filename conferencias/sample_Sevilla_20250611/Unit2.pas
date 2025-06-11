unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Soap.InvokeRegistry,
  System.Net.URLClient, System.Net.HttpClient, Soap.SOAPHTTPTrans, Soap.Rio,
  Soap.SOAPHTTPClient;

type
  TForm2 = class(TForm)
    Button1: TButton;
    HTTPRIO1: THTTPRIO;
    HTTPReqResp1: THTTPReqResp;
    procedure Button1Click(Sender: TObject);
    procedure HTTPReqResp1NeedClientCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const ACertificateList: TCertificateList;
      var AnIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses SistemaFacturacion;

procedure TForm2.Button1Click(Sender: TObject);
var
  registro: RegFactuSistemaFacturacion;
  respuesta: RespuestaRegFactuSistemaFacturacion;
begin
  registro := RegFactuSistemaFacturacion.Create;
  // registro.Cabecera.Representante.NIF:='';
  var
  factura := RegistroFacturaType.Create;
  // factura.RegistroAlta.ImporteTotal:= '500';

  var
    facturas: Array_Of_RegistroFacturaType;
  SetLength(facturas, 1);
  facturas[0] := factura;
  registro.RegistroFactura := facturas;
  respuesta := GetsfPortTypeVerifactu(true, '', HTTPRIO1)
    .RegFactuSistemaFacturacion(registro);
  showmessage(respuesta.CSV);
  // GetsfPortTypeVerifactu.ConsultaFactuSistemaFacturacion()
  // GetsfPortTypePorRequerimiento.RegFactuSistemaFacturacion()
end;

procedure TForm2.HTTPReqResp1NeedClientCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const ACertificateList: TCertificateList;
  var AnIndex: Integer);
begin
  ///
  showmessage(ACertificateList[0].CertName);
  AnIndex := 0;
end;

end.
