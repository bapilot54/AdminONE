Public Class TimeLine
    Inherits System.Web.UI.Page


    ' Load
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            If Request.QueryString("IID") IsNot Nothing Then
                hidden_InstallationID.Value = Request.QueryString("IID").ToString
                ds_repeater.SelectParameters("InstallationID").DefaultValue = hidden_InstallationID.Value
            End If

        End If

    End Sub


    ' TimeLine Repeater - Created
    Private Sub Repeater_ItemCreated(sender As Object, e As RepeaterItemEventArgs) Handles Repeater.ItemCreated

        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then

            Dim literalLabel As Literal = e.Item.FindControl("literal_Label")

            ' Step 1 - Initial Data
            If e.Item.ItemIndex = 0 Then
                ' Get the Vendor details and Zeiss Nominations from the Database
                Using dtcontext As New DataClassesDataContext
                    Dim indexzero = From a In dtcontext.ForumInstallationDetails Where a.InstallationID = hidden_InstallationID.Value Select a
                    If indexzero.FirstOrDefault IsNot Nothing Then
                        literalLabel.Text = "<strong>Vendor Name : </strong>" & indexzero.FirstOrDefault.VendorName &
                            "</br>" &
                            "<strong>FORUM SalesPerson : </strong>" & indexzero.FirstOrDefault.ZeissSalesPerson &
                         "</br>" &
                            "<strong>FORUM Engineer : </strong>" & indexzero.FirstOrDefault.ZeissEngineer
                    End If
                End Using
            End If


            ' Step 2 - Initial Quotation
            If e.Item.ItemIndex = 1 Then
                ' Get the Initital Quotation Products from the Database
                Using dtcontext As New DataClassesDataContext
                    Dim indexone = From a In dtcontext.ForumSiteSurveys Where a.InstallationID = hidden_InstallationID.Value Select a
                    If indexone.FirstOrDefault IsNot Nothing Then
                        literalLabel.Text = "<strong>FORUM Archive and Viewer / Viewer Licences : </strong>" & indexone.FirstOrDefault.ArchiveAndViewer.Value & " / " & indexone.FirstOrDefault.FORUMUserLicences.ToString &
                        "</br>" &
                        "<strong>Glaucoma Workplace / User Licences : </strong>" & indexone.FirstOrDefault.GlaucomaWorkplaceMain.Value & " / " & indexone.FirstOrDefault.GlaucomaWorkplaceUserLicences.Value &
                        "</br>" &
                        "<strong>Retina Workplace / User Licences : </strong>" & indexone.FirstOrDefault.RetinaWorkplaceMain.Value & " / " & indexone.FirstOrDefault.RetinaWorkplaceUserLicences.Value &
                        "</br>" &
                        "<strong>Zeiss Device Connections : </strong>" & indexone.FirstOrDefault.ZeissDeviceConnections.Value &
                        "</br>" &
                        "<strong>3rd Party Device Connections : </strong>" & indexone.FirstOrDefault.ThirdPartyDeviceConnections.Value &
                        "</br>" &
                        "<strong>EMR Connectivity / Data Cleanse : </strong>" & indexone.FirstOrDefault.EMRVendor & " / " & indexone.FirstOrDefault.DataCleanseRequired.Value
                    End If
                End Using
            End If

        End If

    End Sub


    ' Button Commands
    Private Sub Repeater_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles Repeater.ItemCommand

        Dim ID As String = hidden_InstallationID.Value

        If e.CommandName = "1" Then
            Response.Redirect("/Forum/NewEditInstallation.aspx?IID=" & ID)
        End If

    End Sub
End Class