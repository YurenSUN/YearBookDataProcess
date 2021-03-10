Sub ConvertToXlsx()
    Dim strPath As String
    Dim strFile As String
    Dim wbk As Workbook
    
    ' Path must end in trailing backslash
    strPath = "/Users/sun/Desktop/Econ580Data/all/"
    
    ' Get access
    Dim MyFile As String
    Dim Counter As Long
    Dim DirectoryListArray() As String
    ReDim DirectoryListArray(1000)
    MyFile = Dir$(strPath & "*.xls")
    
    Do While MyFile <> ""
        DirectoryListArray(Counter) = strPath & MyFile
        MyFile = Dir$
        Counter = Counter + 1
    Loop

    fileAccessGranted = GrantAccessToMultipleFiles(DirectoryListArray)
    Debug.Print fileAccessGranted

    ' translate to xlsx
    strFile = Dir(strPath & "*.xls")
    Do While strFile <> ""
        If Right(strFile, 3) = "xls" Then
       
            Set wbk = Workbooks.Open(FileName:=strPath & strFile)
           
            If wbk.HasVBProject Then
              wbk.SaveAs FileName:=strPath & strFile & "m", _
                FileFormat:=xlOpenXMLWorkbookMacroEnabled
            Else
               wbk.SaveAs FileName:=strPath & strFile & "x", _
                FileFormat:=xlOpenXMLWorkbook
            End If
            wbk.Close SaveChanges:=False
        End If
        strFile = Dir
    Loop
End Sub