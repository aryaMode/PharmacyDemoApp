Private Sub cmd_Click()
 Dim A,  F As Integer 'A=InputBox("Enter the temperature in degrees") A = Range("B2").Value F = (A * 9 / 5) + 32 Range("B11").Value = F  MsgBox ("The temperature in fahrenheit is " & F)  End Sub
