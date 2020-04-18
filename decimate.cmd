@echo off
rem vim: set nowrap:

rem decimate.cmd
rem Decimate a mesh using meshlab's Quadratic Edge Collapse Decimation
rem
rem USAGE:
rem   decimate <filename.ext> <face_count>
rem Output:
rem   creates filename-decimated.ext

setlocal

if [%1]==[] goto usage
if [%2]==[] goto usage

if not exist %1 goto :nofile


rem set "MESHLABSERVER=C:\Program Files\VCG\MeshLab\meshlabserver.exe"
set "MESHLABSERVER=C:\Users\Jim\scoop\shims\meshlabserver.exe"
set "FILTER=%TEMP%\decimate.mlx"
set "FACES=%2"


echo Writing filter script...

(
echo ^<!DOCTYPE FilterScript^>
echo ^<FilterScript^>
echo ^<filter name="Remove Duplicate Vertices"/^>
echo ^<filter name="Simplification: Quadric Edge Collapse Decimation"^>
echo ^<Param type="RichInt" tooltip="The desired final number of faces." name="TargetFaceNum" value="%FACES%" description="Target number of faces"/^>
echo ^<Param type="RichFloat" tooltip="If non zero, this parameter specifies the desired final size of the mesh as a percentage of the initial size." name="TargetPerc" value="0.0" description="Percentage reduction (0..1)"/^>
echo ^<Param type="RichFloat" tooltip="Quality threshold for penalizing bad shaped faces.&lt;br>The value is in the range [0..1]&#xa; 0 accept any kind of face (no penalties),&#xa; 0.5  penalize faces with quality &lt; 0.5, proportionally to their shape&#xa;" name="QualityThr" value="0.3" description="Quality threshold"/^>
echo ^<Param type="RichBool" tooltip="The simplification process tries to do not affect mesh boundaries during simplification" name="PreserveBoundary" value="false" description="Preserve Boundary of the mesh"/^>
echo ^<Param type="RichFloat" tooltip="The importance of the boundary during simplification. Default (1.0) means that the boundary has the same importance of the rest. Values greater than 1.0 raise boundary importance and has the effect of removing less vertices on the border. Admitted range of values (0,+inf). " name="BoundaryWeight" value="1" description="Boundary Preserving Weight"/^>
echo ^<Param type="RichBool" tooltip="Try to avoid face flipping effects and try to preserve the original orientation of the surface" name="PreserveNormal" value="false" description="Preserve Normal"/^>
echo ^<Param type="RichBool" tooltip="Avoid all the collapses that should cause a topology change in the mesh (like closing holes, squeezing handles, etc). If checked the genus of the mesh should stay unchanged." name="PreserveTopology" value="false" description="Preserve Topology"/^>
echo ^<Param type="RichBool" tooltip="Each collapsed vertex is placed in the position minimizing the quadric error.&#xa; It can fail (creating bad spikes) in case of very flat areas. &#xa;If disabled edges are collapsed onto one of the two original vertices and the final mesh is composed by a subset of the original vertices. " name="OptimalPlacement" value="true" description="Optimal position of simplified vertices"/^>
echo ^<Param type="RichBool" tooltip="Add additional simplification constraints that improves the quality of the simplification of the planar portion of the mesh." name="PlanarQuadric" value="false" description="Planar Simplification"/^>
echo ^<Param type="RichBool" tooltip="Use the Per-Vertex quality as a weighting factor for the simplification. The weight is used as a error amplification value, so a vertex with a high quality value will not be simplified and a portion of the mesh with low quality values will be aggressively simplified." name="QualityWeight" value="false" description="Weighted Simplification"/^>
echo ^<Param type="RichBool" tooltip="After the simplification an additional set of steps is performed to clean the mesh (unreferenced vertices, bad faces, etc)" name="AutoClean" value="true" description="Post-simplification cleaning"/^>
echo ^<Param type="RichBool" tooltip="The simplification is applied only to the selected set of faces.&#xa; Take care of the target number of faces!" name="Selected" value="false" description="Simplify only selected faces"/^>
echo ^</filter^>
echo ^</FilterScript^>
) > %filter%

set OUT="%~n1-decimated%~x1"
echo Output: %OUT%

echo Running meshlab...
%MESHLABSERVER% -i %1 -o %OUT% -s %FILTER%
goto :eof

:usage
echo Usage: decimate ^<filename^> ^<face-count^>
echo   filename   - The name of the file to decimate.
echo   face-count - The desired number of faces (Integer).
goto :eof

:nofile
echo Error: file %1 does not exist.
goto :usage

:usage
echo Usage:
echo   decimate ^<filename.ext^> ^<face count^>
echo.
