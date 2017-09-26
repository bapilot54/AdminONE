Imports DevExpress.Web.Data

Public Class ProductGroups
    Inherits System.Web.UI.Page


    ' Dims for Delete Command
    Public productDescriptionforDeleteModal As String
    Dim isDeleting As Boolean


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    ' Add inert values when inserting new rows
    Private Sub gv_productGroups_RowInserting(sender As Object, e As ASPxDataInsertingEventArgs) Handles gv_productGroups.RowInserting
        e.NewValues.Item("ID") = Guid.Parse(Guid.NewGuid.ToString)
    End Sub


    ' Confirm Delete
    Private Sub gv_productGroups_RowDeleting(sender As Object, e As ASPxDataDeletingEventArgs) Handles gv_productGroups.RowDeleting

        If isDeleting = False Then
            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "hide", "$('#modal_deleteConfirm').modal('show');", True)
            productDescriptionforDeleteModal = e.Values("ProductGroup").ToString
            e.Cancel = True
        End If

        isDeleting = False

    End Sub


    ' Delete Code
    Protected Sub btn_confirmDelete_Click(sender As Object, e As EventArgs)

        isDeleting = True
        Dim index As Integer = gv_productGroups.FocusedRowIndex
        gv_productGroups.DeleteRow(index)

    End Sub
End Class