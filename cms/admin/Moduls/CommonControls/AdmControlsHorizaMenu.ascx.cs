using System;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Extension;

public partial class cms_admin_Controls_HorizalMenu_AdmControlsHorizaMenu : System.Web.UI.UserControl
{
  private string uc = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["uc"] != null)
    {
      uc = Request.QueryString["uc"].ToString();
    }
    if (!IsPostBack)
    {
      PnMenu.Visible = HorizaMenuConfig.ShowMenu;
      PnContent.Visible = HorizaMenuConfig.ShowContent;
      PnProduct.Visible = HorizaMenuConfig.ShowProduct;
      PnNew.Visible = HorizaMenuConfig.ShowNew;
      PnTour.Visible = HorizaMenuConfig.ShowTour;
      pnHotel.Visible = HorizaMenuConfig.ShowHotel;
      PnTrainTicket.Visible = HorizaMenuConfig.ShowTrainTicket;
      PnService.Visible = HorizaMenuConfig.ShowService;
      PnPhotoAlbum.Visible = HorizaMenuConfig.ShowPhotoAlbum;
      PnFileLibrary.Visible = HorizaMenuConfig.ShowFilelibrary;
      PnVideo.Visible = HorizaMenuConfig.ShowVideo;
      PnAdvertising.Visible = HorizaMenuConfig.ShowAdv;
      PnContact.Visible = HorizaMenuConfig.ShowContact;
      PnMember.Visible = HorizaMenuConfig.ShowMember;
      pnQA.Visible = HorizaMenuConfig.ShowQA;
      pnDeal.Visible = HorizaMenuConfig.ShowDeal;
      pnCustomer.Visible = HorizaMenuConfig.ShowCustomer;

      PnOther.Visible = HorizaMenuConfig.ShowOther;
      PnSupportOnline.Visible = HorizaMenuConfig.ShowSupportOnline;
      PnPsg.Visible = HorizaMenuConfig.ShowPsg;
      PnVote.Visible = HorizaMenuConfig.ShowVote;
      pnSiteMap.Visible = HorizaMenuConfig.ShowSiteMap;
      pnDcLink.Visible = HorizaMenuConfig.ShowDcLink;

      PnTag.Visible = HorizaMenuConfig.ShowTag;
      PnFileLibrary2.Visible = HorizaMenuConfig.ShowFilelibrary2;

      PnCopyItem.Visible = HorizaMenuConfig.ShowCopyItem;

      PnEmail.Visible = HorizaMenuConfig.ShowEmail;

      pnCruises.Visible = HorizaMenuConfig.ShowCruises;
      pnDestination.Visible = HorizaMenuConfig.ShowDestination;

      pnAboutUs.Visible = HorizaMenuConfig.ShowAboutUs;
      pnCustomerReviews.Visible = HorizaMenuConfig.ShowCustomerReviews;
      pnBlog.Visible = HorizaMenuConfig.ShowBlog;

      ShowDuyetTin();
    }
  }

  void ShowDuyetTin()
  {
    string userRole = CookieExtension.GetCookies("RolesUser");
    #region Với tính năng duyệt tin 2 cấp (phóng viên, biên tập => trưởng ban biên tập => tổng biên tập)
    if (HorizaMenuConfig.ShowDuyetTin2)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
      {
        #region Với tài khoản cấp 1 (phóng viên, biên tập viên)
        pnQuanLyDanhMucAboutUs.Visible = false;
        pnThemMoiDanhMucAboutUs.Visible = false;
        pnQuanLyDanhMucProduct.Visible = false;
        pnThemMoiDanhMucProduct.Visible = false;
        pnQuanLyDanhMucDeal.Visible = false;
        pnThemMoiDanhMucDeal.Visible = false;
        pnQuanLyDanhMucFileLibrary.Visible = false;
        pnThemMoiDanhMucFileLibrary.Visible = false;
        pnQuanLyDanhMucService.Visible = false;
        pnThemMoiDanhMucService.Visible = false;
        pnQuanLyDanhMucNew.Visible = false;
        pnThemMoiDanhMucNew.Visible = false;
        pnQuanLyDanhMucPhotoAlbum.Visible = false;
        pnThemMoiDanhMucPhotoAlbum.Visible = false;
        pnQuanLyDanhMucVideo.Visible = false;
        pnThemMoiDanhMucVideo.Visible = false;
        pnQuanLyDanhMucQA.Visible = false;
        pnThemMoiDanhMucQA.Visible = false;
        pnQuanLyDanhMucCustomerReviews.Visible = false;
        pnThemMoiDanhMucCustomerReviews.Visible = false;
        pnQuanLyViTriQuangCao.Visible = false;
        pnThemMoiViTriQuangCao.Visible = false;
        #endregion
      }
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
      {
        #region Với tài khoản cấp 2 (trưởng ban biên tập)
        pnDuyetTin.Visible = true;
        #endregion
      }
      else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
      {
        #region Với tài khoản cấp 3 (tổng biên tập)
        pnDuyetTin.Visible = true;
        #endregion
      }
    }
    #endregion
    #region Với tính năng duyệt tin 1 cấp (phóng viên, biên tập viên => tổng biên tập)
    else if (HorizaMenuConfig.ShowDuyetTin1)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
      {
        #region Với tài khoản cấp 2 (phóng viên, biên tập)
        pnQuanLyDanhMucAboutUs.Visible = false;
        pnThemMoiDanhMucAboutUs.Visible = false;
        pnQuanLyDanhMucProduct.Visible = false;
        pnThemMoiDanhMucProduct.Visible = false;
        pnQuanLyDanhMucDeal.Visible = false;
        pnThemMoiDanhMucDeal.Visible = false;
        pnQuanLyDanhMucFileLibrary.Visible = false;
        pnThemMoiDanhMucFileLibrary.Visible = false;
        pnQuanLyDanhMucService.Visible = false;
        pnThemMoiDanhMucService.Visible = false;
        pnQuanLyDanhMucNew.Visible = false;
        pnThemMoiDanhMucNew.Visible = false;
        pnQuanLyDanhMucPhotoAlbum.Visible = false;
        pnThemMoiDanhMucPhotoAlbum.Visible = false;
        pnQuanLyDanhMucVideo.Visible = false;
        pnThemMoiDanhMucVideo.Visible = false;
        pnQuanLyDanhMucQA.Visible = false;
        pnThemMoiDanhMucQA.Visible = false;
        pnQuanLyDanhMucCustomerReviews.Visible = false;
        pnThemMoiDanhMucCustomerReviews.Visible = false;
        pnQuanLyViTriQuangCao.Visible = false;
        pnThemMoiViTriQuangCao.Visible = false;
        #endregion
      }
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
      {
        #region Với tài khoản cấp 3 (tổng biên tập)
        pnDuyetTin.Visible = true;
        #endregion
      }
    }
    #endregion
  }

  protected string GetCurrent(string typeModul)
  {
    string str = "";
    if (Request.QueryString["uc"] != null)
    {
      if (Request.QueryString["uc"].Equals(typeModul))
      {
        str = " currentMenu";
      }
    }

    return str;
  }

}
