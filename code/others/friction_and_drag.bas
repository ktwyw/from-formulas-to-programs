' Darcy friction factor (Swamee-Jain), usable in a cell as =FRICTION(B2, C2)
Function FRICTION(Re As Double, relRough As Double) As Double
    If Re < 2300 Then
        FRICTION = 64 / Re
    Else
        FRICTION = 0.25 / (Log(relRough / 3.7 + 5.74 / Re ^ 0.9) / Log(10)) ^ 2
    End If
End Function

' A macro that fills a table with the Euler solution of the drag problem
Sub DragTable()
    Dim m As Double, c As Double, g As Double, dt As Double, v As Double
    Dim n As Integer
    m = 80: c = 0.25: g = 9.81: dt = 0.5: v = 0
    Range("A1:B1").Value = Array("t (s)", "v (m/s)")
    For n = 0 To 40
        Cells(n + 2, 1).Value = n * dt
        Cells(n + 2, 2).Value = v
        v = v + dt * (g - c / m * v ^ 2)
    Next n
End Sub
