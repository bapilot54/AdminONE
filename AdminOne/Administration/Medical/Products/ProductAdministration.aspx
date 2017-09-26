<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="ProductAdministration.aspx.vb" Inherits="AdminOne.ProductAdministration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <%-- Product Administration --%>
    <div class="ibox">
        <div class="ibox-title">
            <h5>Product Administration</h5>
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

                            <dx:ASPxGridView ID="gv_products" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="ds_productManagement" KeyFieldName="ID" EnableCallBacks="false">
                                <SettingsEditing Mode="EditForm"></SettingsEditing>
                                <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>

                                <Settings ShowGroupPanel="True"></Settings>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                <SettingsPopup>
                                    <EditForm HorizontalAlign="Center" VerticalAlign="Middle"></EditForm>
                                </SettingsPopup>

                                <SettingsSearchPanel Visible="True" ShowClearButton="True"></SettingsSearchPanel>

                                <EditFormLayoutProperties ColCount="2">
                                    <Items>
                                        <dx:GridViewLayoutGroup ColSpan="2" Caption="Product Information">
                                            <Items>
                                                <dx:GridViewColumnLayoutItem ColumnName="ProductDescription"></dx:GridViewColumnLayoutItem>
                                                <dx:GridViewColumnLayoutItem ColumnName="ProductSubDescription"></dx:GridViewColumnLayoutItem>
                                                <dx:GridViewColumnLayoutItem ColumnName="PartNumber"></dx:GridViewColumnLayoutItem>
                                                <dx:GridViewColumnLayoutItem ColumnName="Active"></dx:GridViewColumnLayoutItem>
                                                <dx:GridViewColumnLayoutItem ColumnName="Product Group"></dx:GridViewColumnLayoutItem>
                                            </Items>
                                        </dx:GridViewLayoutGroup>
                                        <dx:GridViewLayoutGroup ColCount="2" ColSpan="2" Caption="Pricing">
                                            <Items>
                                                <dx:GridViewColumnLayoutItem ColumnName="PriceAUD"></dx:GridViewColumnLayoutItem>
                                                <dx:GridViewColumnLayoutItem ColumnName="PriceNZD"></dx:GridViewColumnLayoutItem>
                                            </Items>
                                        </dx:GridViewLayoutGroup>
                                        <dx:GridViewLayoutGroup ColSpan="2" Caption="Notes">
                                            <Items>
                                                <dx:GridViewColumnLayoutItem ColumnName="Internal Notes" RowSpan="4"></dx:GridViewColumnLayoutItem>
                                                <dx:GridViewColumnLayoutItem ColumnName="Vendor Viewable Notes" RowSpan="4"></dx:GridViewColumnLayoutItem>
                                            </Items>
                                        </dx:GridViewLayoutGroup>

                                        <dx:EditModeCommandLayoutItem ColSpan="2" HorizontalAlign="Right"></dx:EditModeCommandLayoutItem>
                                    </Items>
                                </EditFormLayoutProperties>
                                <Columns>
                                    <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True" ShowDeleteButton="True" ButtonRenderMode="Button" ButtonType="Button"></dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ProductDescription" VisibleIndex="2">
                                        <PropertiesTextEdit>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" Display="Dynamic" ErrorText="Required" SetFocusOnError="True">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ProductSubDescription" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PartNumber" VisibleIndex="4">
                                        <PropertiesTextEdit Width="300px">
                                            <MaskSettings Mask="000000-0000-000" ShowHints="True"></MaskSettings>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" Display="Dynamic" ErrorText="Required" SetFocusOnError="True">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PriceAUD" VisibleIndex="5">
                                        <PropertiesTextEdit DisplayFormatInEditMode="True" DisplayFormatString="c2">
                                        </PropertiesTextEdit>
                                        <PropertiesTextEdit>
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" Display="Dynamic" ErrorText="Required" SetFocusOnError="True">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PriceNZD" VisibleIndex="6">
                                        <PropertiesTextEdit DisplayFormatInEditMode="True" DisplayFormatString="c2">
                                            <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" Display="Dynamic" ErrorText="Required" SetFocusOnError="True">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Active" VisibleIndex="9" Visible="False"></dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataMemoColumn FieldName="InternalNotes" VisibleIndex="7" Visible="False">
                                        <PropertiesMemoEdit Rows="4"></PropertiesMemoEdit>
                                    </dx:GridViewDataMemoColumn>
                                    <dx:GridViewDataMemoColumn FieldName="VendorViewableNotes" VisibleIndex="8" Visible="False">
                                        <PropertiesMemoEdit Rows="4"></PropertiesMemoEdit>
                                    </dx:GridViewDataMemoColumn>
                                    <dx:GridViewDataTextColumn FieldName="ProductGroup" VisibleIndex="10">
                                        <EditItemTemplate>
                                            <dx:ASPxComboBox ID="combo_productGroup" runat="server" DataSourceID="ds_productGroups" TextField="ProductGroup" ValueField="ProductGroup" Width="300px" ValidationSettings-ValidationGroup='<%# Container.ValidationGroup %>'>
                                                <ValidationSettings ErrorDisplayMode="None" CausesValidation="True" Display="Dynamic" ErrorText="Required" SetFocusOnError="True">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource runat="server" ID="ds_productGroups" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT * FROM [Med_ProductGroups] ORDER BY [ProductGroup]"></asp:SqlDataSource>
                                        </EditItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:ASPxGridView>

                            <asp:SqlDataSource runat="server" ID="ds_productManagement" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' DeleteCommand="DELETE FROM [Med_Products] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Med_Products] ([ID], [ProductDescription], [ProductSubDescription], [PartNumber], [ProductGroup], [PriceAUD], [PriceNZD], [InternalNotes], [VendorViewableNotes], [Active], [PackageItemOnly]) VALUES (@ID, @ProductDescription, @ProductSubDescription, @PartNumber, @ProductGroup, @PriceAUD, @PriceNZD, @InternalNotes, @VendorViewableNotes, @Active, @PackageItemOnly)" SelectCommand="SELECT * FROM [Med_Products] WHERE ([PackageItemOnly] IS NULL) ORDER BY [ProductDescription]" UpdateCommand="UPDATE [Med_Products] SET [ProductDescription] = @ProductDescription, [ProductSubDescription] = @ProductSubDescription, [PartNumber] = @PartNumber, [ProductGroup] = @ProductGroup, [PriceAUD] = @PriceAUD, [PriceNZD] = @PriceNZD, [InternalNotes] = @InternalNotes, [VendorViewableNotes] = @VendorViewableNotes, [Active] = @Active, [PackageItemOnly] = @PackageItemOnly WHERE [ID] = @ID">
                                <DeleteParameters>
                                    <asp:Parameter Name="ID"></asp:Parameter>
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ID"></asp:Parameter>
                                    <asp:Parameter Name="ProductDescription" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="ProductSubDescription" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="PartNumber" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="ProductGroup" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="PriceAUD" Type="Decimal"></asp:Parameter>
                                    <asp:Parameter Name="PriceNZD" Type="Decimal"></asp:Parameter>
                                    <asp:Parameter Name="InternalNotes" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="VendorViewableNotes" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="Active" Type="Boolean"></asp:Parameter>
                                    <asp:Parameter Name="PackageItemOnly" Type="Boolean"></asp:Parameter>
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ProductDescription" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="ProductSubDescription" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="PartNumber" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="ProductGroup" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="PriceAUD" Type="Decimal"></asp:Parameter>
                                    <asp:Parameter Name="PriceNZD" Type="Decimal"></asp:Parameter>
                                    <asp:Parameter Name="InternalNotes" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="VendorViewableNotes" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="Active" Type="Boolean"></asp:Parameter>
                                    <asp:Parameter Name="PackageItemOnly" Type="Boolean"></asp:Parameter>
                                    <asp:Parameter Name="ID"></asp:Parameter>
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
