Private Sub cmd_Click()
Dim A, B, F As Integer
'A=InputBox("Enter the radius")
'B=InputBox("Enter the height of the cylinder")
A = Range("B2").Value
F = (A * 9 / 5) + 32
Range("B11").Value = F

MsgBox ("The temperature in fahrenheit is " & F)

End Sub