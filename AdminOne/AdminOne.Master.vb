Public Class AdminOne
    Inherits System.Web.UI.MasterPage

    Public _FullName As String
    Public _ReportingDivision As String


    ' Load
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Load User Details
        Dim currentUser = Membership.GetUser(HttpContext.Current.User.Identity.Name)
        If (currentUser IsNot Nothing) Then

            Dim dtcontext As New DataClassesDataContext
            Dim result = From a In dtcontext.aspnet_Users Join u In dtcontext.AdditionalUserDetails On a.UserId Equals u.UserID Where a.UserName = HttpContext.Current.User.Identity.Name Select a, u
            If result.FirstOrDefault IsNot Nothing Then
                _FullName = result.FirstOrDefault.u.FullName
                _ReportingDivision = result.FirstOrDefault.u.ReportingDivision
            End If

        End If

    End Sub


End Class