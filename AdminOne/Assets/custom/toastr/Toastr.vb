Imports Microsoft.VisualBasic
Imports System.Web.UI

Public Class Toastr

    Public Enum ToastType
        Success
        Info
        Warning
        [Error] 'Reserved word
    End Enum

    Public Enum ToastPosition
        TopRight
        TopLeft
        TopCenter
        TopStretch
        BottomRight
        BottomLeft
        BottomCenter
        BottomStretch
    End Enum

    Public Shared Sub ShowToast_UpdatePanel(Cont As Control, Type As ToastType, Msg As String, Optional Title As String = "",
                                            Optional Position As ToastPosition = ToastPosition.BottomRight,
                                            Optional ShowCloseButton As Boolean = True)
        Dim strType = "", strPosition = ""

        Select Case Type
            Case ToastType.Success
                strType = "success"
            Case ToastType.Info
                strType = "info"
            Case ToastType.Warning
                strType = "warning"
            Case ToastType.Error
                strType = "error"
        End Select

        'Set the position based on selected and change value to match toastr plugin
        Select Case Position
            Case ToastPosition.TopRight
                strPosition = "toast-top-right"
            Case ToastPosition.TopLeft
                strPosition = "toast-top-left"
            Case ToastPosition.TopCenter
                strPosition = "toast-top-center"
            Case ToastPosition.TopStretch
                strPosition = "toast-top-full-width"
            Case ToastPosition.BottomRight
                strPosition = "toast-bottom-right"
            Case ToastPosition.BottomLeft
                strPosition = "toast-bottom-left"
            Case ToastPosition.BottomCenter
                strPosition = "toast-bottom-center"
            Case ToastPosition.BottomStretch
                strPosition = "toast-bottom-full-width"
        End Select

        'Call the toastify() function in script.js
        Dim script = "toastify('" & strType & "', '" & CleanStr(Msg) & "', '" & CleanStr(Title) & "', '" & strPosition & "', '" & ShowCloseButton.ToString.ToLower & "');"
        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "toastedMsg", script, True)

        ScriptManager.RegisterStartupScript(Cont, GetType(Page), "toastedMsg", script, True)

    End Sub

    Public Shared Sub ShowToast(Page As Page, Type As ToastType, Msg As String, Optional Title As String = "",
                                            Optional Position As ToastPosition = ToastPosition.BottomRight,
                                            Optional ShowCloseButton As Boolean = True)
        Dim strType = "", strPosition = ""

        Select Case Type
            Case ToastType.Success
                strType = "success"
            Case ToastType.Info
                strType = "info"
            Case ToastType.Warning
                strType = "warning"
            Case ToastType.Error
                strType = "error"
        End Select

        'Set the position based on selected and change value to match toastr plugin
        Select Case Position
            Case ToastPosition.TopRight
                strPosition = "toast-top-right"
            Case ToastPosition.TopLeft
                strPosition = "toast-top-left"
            Case ToastPosition.TopCenter
                strPosition = "toast-top-center"
            Case ToastPosition.TopStretch
                strPosition = "toast-top-full-width"
            Case ToastPosition.BottomRight
                strPosition = "toast-bottom-right"
            Case ToastPosition.BottomLeft
                strPosition = "toast-bottom-left"
            Case ToastPosition.BottomCenter
                strPosition = "toast-bottom-center"
            Case ToastPosition.BottomStretch
                strPosition = "toast-bottom-full-width"
        End Select

        'Call the toastify() function in script.js
        Dim script = "toastify('" & strType & "', '" & CleanStr(Msg) & "', '" & CleanStr(Title) & "', '" & strPosition & "', '" & ShowCloseButton.ToString.ToLower & "');"
        Page.ClientScript.RegisterStartupScript(Page.GetType(), "toastedMsg", script, True)

    End Sub

    Private Shared Function CleanStr(Text As String) As String
        'This function replaces ' with its html code equiv
        'in order not to terminate the js statement string
        Return Text.Replace("'", "&#39;")
    End Function
End Class
