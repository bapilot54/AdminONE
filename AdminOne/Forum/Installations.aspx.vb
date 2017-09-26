Imports DevExpress.Web

Public Class Installations
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    ' Create a New Installation
    Protected Sub btn_createNewInstallation_Click(sender As Object, e As EventArgs)
        Response.Redirect("/Forum/NewEditInstallation.aspx")
    End Sub


    ' Custom Button Callback
    Private Sub gv_activeInstallations_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles gv_activeInstallations.CustomButtonCallback

        Dim ID = gv_activeInstallations.GetRowValues(e.VisibleIndex, "InstallationID")

        If e.ButtonID = "Edit" Then
            Response.Redirect("/Forum/NewEditInstallation.aspx?IID=" & ID)
        End If

        If e.ButtonID = "TimeLine" Then
            Response.Redirect("/Forum/TimeLine.aspx?IID=" & ID)
        End If

    End Sub
End Class