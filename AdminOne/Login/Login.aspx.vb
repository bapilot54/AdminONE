Public Class Login
    Inherits System.Web.UI.Page


    ' Load
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Check for a Logout QueryString (Logout=1), this is passed when Logout is Clicked from the Application
        If Request.QueryString("Logout") IsNot Nothing Then
            If Request.QueryString("Logout") = "1" Then
                FormsAuthentication.SignOut()
            End If
        End If

    End Sub


    ' Login Button
    Protected Sub btn_login_Click(sender As Object, e As EventArgs)

        ' Hide the Alert Message
        alert_loginerror.Visible = False

        ' Validate the User against the Database
        If Membership.ValidateUser(tb_email.Text, tb_password.Text) Then

            ' Check if a force Password Change is in place
            'Using dtcontext As New DataClassesDataContext
            '    Dim userName As aspnet_User = dtcontext.aspnet_Users.FirstOrDefault(Function(s) s.UserName.Equals(tb_email.Text.Trim.ToLower))
            '    'If userName.ForceChangePassword = True Then
            '    '    Response.Redirect("/UserProfile/ChangePassword.aspx?UID=" & tb_email.Text.Trim.ToLower)
            '    'End If
            'End Using

            FormsAuthentication.RedirectFromLoginPage(tb_email.Text, cb_rememberMe.Checked)

        Else
            alert_loginerror.Visible = True
        End If

    End Sub



End Class