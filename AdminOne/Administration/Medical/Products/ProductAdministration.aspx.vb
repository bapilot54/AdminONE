Imports DevExpress.Web
Imports DevExpress.Web.Data

Public Class ProductAdministration
    Inherits System.Web.UI.Page


    ' Dims for Delete Command
    Public productDescriptionforDeleteModal As String
    Dim isDeleting As Boolean


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    ' Add other missing fields before inserting into the Database - New Row
    Private Sub gv_products_RowInserting(sender As Object, e As ASPxDataInsertingEventArgs) Handles gv_products.RowInserting

        e.NewValues.Item("ID") = Guid.Parse(Guid.NewGuid.ToString)
        e.NewValues.Item("Active") = True

        ' Set the selected Product Group Value to the Database
        Dim cb As ASPxComboBox = DirectCast(gv_products.FindEditRowCellTemplateControl(TryCast(gv_products.Columns("ProductGroup"), GridViewDataColumn), "combo_productGroup"), ASPxComboBox)
        e.NewValues.Item("ProductGroup") = cb.Value

    End Sub


    ' Add other missing fields before Updating the Database - Update
    Private Sub gv_products_RowUpdating(sender As Object, e As ASPxDataUpdatingEventArgs) Handles gv_products.RowUpdating

        ' Set the selected Product Group Value to the Database
        Dim cb As ASPxComboBox = DirectCast(gv_products.FindEditRowCellTemplateControl(TryCast(gv_products.Columns("ProductGroup"), GridViewDataColumn), "combo_productGroup"), ASPxComboBox)
        e.NewValues.Item("ProductGroup") = cb.Value

    End Sub


    ' Fill the Product Group Combo Box on Edit Form Load with the selected value
    Private Sub gv_products_HtmlEditFormCreated(sender As Object, e As ASPxGridViewEditFormEventArgs) Handles gv_products.HtmlEditFormCreated

        If gv_products.IsNewRowEditing = True Then
            Exit Sub
        End If

        Dim cb As ASPxComboBox = DirectCast(gv_products.FindEditRowCellTemplateControl(TryCast(gv_products.Columns("ProductGroup"), GridViewDataColumn), "combo_productGroup"), ASPxComboBox)

        ' Get the Selected row
        Dim index As Integer = gv_products.FocusedRowIndex

        If index = -1 Then
            Exit Sub
        End If

        Dim ProductGroup As String = gv_products.GetRowValues(index, "ProductGroup")
        cb.Value = ProductGroup

    End Sub


    ' Confirm Delete
    Private Sub gv_products_RowDeleting(sender As Object, e As ASPxDataDeletingEventArgs) Handles gv_products.RowDeleting

        If isDeleting = False Then
            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "hide", "$('#modal_deleteConfirm').modal('show');", True)
            productDescriptionforDeleteModal = e.Values("ProductDescription").ToString
            e.Cancel = True
        End If

        isDeleting = False

    End Sub


    ' Delete Code
    Protected Sub btn_confirmDelete_Click(sender As Object, e As EventArgs)

        isDeleting = True
        Dim index As Integer = gv_products.FocusedRowIndex
        gv_products.DeleteRow(index)

    End Sub
End Class