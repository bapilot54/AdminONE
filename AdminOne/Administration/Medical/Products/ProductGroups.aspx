<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="ProductGroups.aspx.vb" Inherits="AdminOne.ProductGroups" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <%-- Product Groups --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>Product Groups Administration</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-sm-12">

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>

                            <dx:ASPxGridView ID="gv_productGroups" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="ds_productGroups" KeyFieldName="ID" EnableCallBacks="false">
                                <SettingsEditing Mode="EditForm"></SettingsEditing>
                                <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>

                                <Settings ShowGroupPanel="True"></Settings>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                <SettingsSearchPanel Visible="True" ShowClearButton="True"></SettingsSearchPanel>

                                <Columns>
                                    <dx:GridViewCommandColumn Width="120px" ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True" ShowDeleteButton="True" ButtonRenderMode="Button" ButtonType="Button" Caption="Options"></dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="RowID" ReadOnly="True" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ProductGroup" VisibleIndex="2">
                                        <PropertiesTextEdit>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" Display="Dynamic" SetFocusOnError="True">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                </Columns>

                            </dx:ASPxGridView>

                            <asp:SqlDataSource runat="server" ID="ds_productGroups" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' DeleteCommand="DELETE FROM [Med_ProductGroups] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Med_ProductGroups] ([ID], [ProductGroup]) VALUES (@ID, @ProductGroup)" SelectCommand="SELECT * FROM [Med_ProductGroups] ORDER BY [ProductGroup]" UpdateCommand="UPDATE [Med_ProductGroups] SET [ProductGroup] = @ProductGroup WHERE [ID] = @ID">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID"></asp:Parameter>
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ID"></asp:Parameter>
                                    <asp:Parameter Name="ProductGroup" Type="String"></asp:Parameter>
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ProductGroup"></asp:Parameter>
                                    <asp:Parameter Name="ID" Type="Object"></asp:Parameter>
                                </UpdateParameters>
                            </asp:SqlDataSource>


                            <%-- Modal Delete --%>
                            <div class="modal inmodal fade" id="modal_deleteConfirm" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title">Confirm Delete</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>
                                                <strong>This operation cannot be reversed</strong><br />
                                                Please confirm that you wish to delete <%= productDescriptionforDeleteModal %>?
                                            </p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                                            <dx:ASPxButton ID="btn_confirmDelete" runat="server" CssClass="btn btn-danger" Text="Delete" Native="true" AutoPostBack="true" UseSubmitBehavior="false" data-dismiss="modal" OnClick="btn_confirmDelete_Click"></dx:ASPxButton>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
