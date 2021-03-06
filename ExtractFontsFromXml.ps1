param
(
	[string]$filename
)

Function Recurse_Levels
{
 Param 
    (
 [Parameter(Position=0,Mandatory=1)]
 [object]$Some_Object
 ) 
 
 
 If ($Some_Object.HasChildNodes)
 {
  $Child_Nodes = $Some_Object.ChildNodes | Where {$_.NodeType -Eq "Element"}
  ForEach ($Node In $Child_Nodes)
  {
    if ($Node) {
        if ($Node.HasAttribute("style")) {
            $style = $Node.GetAttribute("style");
            $styles = $style.split(";");
            foreach ($pos in $styles) {
                $splitPos = $pos.split(":");
                $pos0 = $splitPos[0];
                $pos1 = $splitPos[1];
                if ($pos0 -eq "font-family") {
                    echo $pos1 | Out-File -append "Types.txt";
                }
            }
        }
        Recurse_Levels $Node
    }
  }
 }
}


[xml]$xml = Get-Content $filename;

Recurse_Levels $xml
