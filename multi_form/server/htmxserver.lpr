program htmxserver;

{$mode objfpc}{$H+}

uses
  sysutils, fpwebfile, fpmimetypes, fphttpapp, httproute, httpdefs;

Var
  aDir : string;

 procedure apiEndpoint (aRequest: TRequest; aResponse: TResponse);
 begin
   aResponse.content :='<h1>HTMX WORKING!</h1>';
   aResponse.Code:=200;
   aResponse.ContentType := 'text/html; charset=utf-8';
   aResponse.ContentLength := length(aResponse.Content);
   aResponse.SendContent;
 end;

procedure projectEndpoint (aRequest: TRequest; aResponse: TResponse);
begin
  aResponse.Contents.Add('<tr><td>Implement interfaces</td><td>May 2018</td></tr>');
  aResponse.Contents.Add('<tr><td>Implement libraries</td><td>Februari 2022</td></tr>');
  aResponse.Contents.Add('<tr><td>PWA Wizard</td><td>March 2022</td></tr>');
  aResponse.Contents.Add('<tr><td>Electron Wizard</td><td>April 2022</td></tr>');
  aResponse.Contents.Add('<tr><td>WebAssembly Widgetset</td><td>December 2022</td></tr>');
  aResponse.Contents.Add('<tr><td>HTMX</td><td>Februari 2023</td></tr>');
  aResponse.ContentType := 'text/html; charset=utf-8';
  aResponse.ContentLength := length(aResponse.Content);
  aResponse.SendContent;
end;


begin
  MimeTypes.LoadKnownTypes;
  Application.Title:='HTMX demo server';
  Application.Port:=3000;
  Application.Initialize;
  if Application.HasOption('d','directory') then
    aDir:=Application.GetOptionValue('d','directory')
  else
    aDir:=ExtractFilePath(ParamStr(0))+'..\webwidget\';
  aDir := ExpandFileName(aDir);
  RegisterFileLocation('webwidget',aDir);
  HTTPRouter.RegisterRoute('/api', @apiEndpoint, false);
  HTTPRouter.RegisterRoute('/projects',@projectEndpoint, false);
  Writeln('open a webbrowser: '+Application.HostName+':'+inttostr(Application.port)+'/webwidget/index.html');

  Application.Run;

end.

