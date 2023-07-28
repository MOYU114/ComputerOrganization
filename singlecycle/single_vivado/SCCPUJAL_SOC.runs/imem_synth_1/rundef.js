//
// Vivado(TM)
// rundef.js: a Vivado-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "F:/vivado/SDK/2017.4/bin;F:/vivado/Vivado/2017.4/ids_lite/ISE/bin/nt64;F:/vivado/Vivado/2017.4/ids_lite/ISE/lib/nt64;F:/vivado/Vivado/2017.4/bin;";
} else {
  PathVal = "F:/vivado/SDK/2017.4/bin;F:/vivado/Vivado/2017.4/ids_lite/ISE/bin/nt64;F:/vivado/Vivado/2017.4/ids_lite/ISE/lib/nt64;F:/vivado/Vivado/2017.4/bin;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


ISEStep( "vivado",
         "-log imem.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source imem.tcl" );



function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}