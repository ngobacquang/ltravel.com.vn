function UpdateEnableItem(iid) {
  var val = "";
  var ElementCssClass = document.getElementById("nc" + iid).className;
  val = ElementCssClass.substring(ElementCssClass.length - 1, ElementCssClass.length)

  $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": val }, function (result) {
    if (val == 0) {
      $("#nc" + iid).removeClass("EnableIcon0");
      $("#nc" + iid).addClass("EnableIcon1");
    }
    else if (val == 1) {
      $("#nc" + iid).removeClass("EnableIcon1");
      $("#nc" + iid).addClass("EnableIcon0");
    }
  });
}

function UpdateEnableItemNew(action ,iid, status, data, uc) {
  var val = "";
  var ElementCssClass = document.getElementById("nc" + iid).className;
  val = ElementCssClass.substring(ElementCssClass.length - 1, ElementCssClass.length)

  if (action !== "") {
    switch (action) {
      case "XuatBanBaiViet":
        jConfirm('Xác nhận xuất bản bài viết này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Xuất bản bài viết thành công!');
            });
          }
        });
        break;
      case "GoBoBaiViet":
        jConfirm('Xác nhận gỡ bỏ bài viết này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Gỡ bỏ bài viết thành công!');
            });
          }
        });
        break;
      case "PheDuyetBaiViet":
        jConfirm('Xác nhận phê duyệt bài viết này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "nguoiduyet": data, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Phê duyệt bài viết thành công!');
            });
          }
        });
        break;
      case "GuiYeuCauPheDuyetBaiViet":
        jConfirm('Xác nhận gửi yêu cầu phê duyệt bài viết này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Gửi yêu cầu thành công!');
            });
          }
        });
        break;
      case "RutLaiBaiViet":
        jConfirm('Xác nhận rút lại yêu cầu phê duyệt bài viết này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Rút lại bài viết thành công!');
            });
          }
        });
        break;
      default:
        $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": val }, function (result) {
          if (val == 0) {
            $("#nc" + iid).removeClass("EnableIcon0");
            $("#nc" + iid).addClass("EnableIcon1");
          }
          else if (val == 1) {
            $("#nc" + iid).removeClass("EnableIcon1");
            $("#nc" + iid).addClass("EnableIcon0");
          }
        });
        break;
    }
  } else {
    $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": val }, function (result) {
      if (val == 0) {
        $("#nc" + iid).removeClass("EnableIcon0");
        $("#nc" + iid).addClass("EnableIcon1");
      }
      else if (val == 1) {
        $("#nc" + iid).removeClass("EnableIcon1");
        $("#nc" + iid).addClass("EnableIcon0");
      }
    });
  }
}

function UpdateEnableItemAdv(action, iid, status, data, uc) {
  var val = "";
  var ElementCssClass = document.getElementById("nc" + iid).className;
  val = ElementCssClass.substring(ElementCssClass.length - 1, ElementCssClass.length)

  if (action !== "") {
    switch (action) {
      case "XuatBanQuangCao":
        jConfirm('Xác nhận xuất bản quảng cáo này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Xuất bản quảng cáo thành công!');
            });
          }
        });
        break;
      case "GoBoQuangCao":
        jConfirm('Xác nhận gỡ bỏ quảng cáo này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Gỡ bỏ quảng cáo thành công!');
            });
          }
        });
        break;
      case "PheDuyetQuangCao":
        jConfirm('Xác nhận phê duyệt quảng cáo này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "nguoiduyet": data, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Phê duyệt quảng cáo thành công!');
            });
          }
        });
        break;
      case "GuiYeuCauPheDuyetQuangCao":
        jConfirm('Xác nhận gửi yêu cầu phê duyệt quảng cáo này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Gửi yêu cầu thành công!');
            });
          }
        });
        break;
      case "RutLaiQuangCao":
        jConfirm('Xác nhận rút lại yêu cầu phê duyệt quảng cáo này?', 'Thông báo', function (r) {
          if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": status, "action": action, "uc": uc }, function (result) {
              $("#Item-" + iid).slideUp();
              ThongBao('3000', 'Rút lại quảng cáo thành công!');
            });
          }
        });
        break;
      default:
        $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": val }, function (result) {
          if (val == 0) {
            $("#nc" + iid).removeClass("EnableIcon0");
            $("#nc" + iid).addClass("EnableIcon1");
          }
          else if (val == 1) {
            $("#nc" + iid).removeClass("EnableIcon1");
            $("#nc" + iid).addClass("EnableIcon0");
          }
        });
        break;
    }
  } else {
    $.post(WebsiteUrl + "cms/admin/Ajax/Items/UpdateEnableItem.aspx", { "iid": iid, "iienable": val }, function (result) {
      if (val == 0) {
        $("#nc" + iid).removeClass("EnableIcon0");
        $("#nc" + iid).addClass("EnableIcon1");
      }
      else if (val == 1) {
        $("#nc" + iid).removeClass("EnableIcon1");
        $("#nc" + iid).addClass("EnableIcon0");
      }
    });
  }
}

function DeleteItem(iid, titleItem) {
  var msg = "<b>Bạn có chắc chắn muốn xóa bản ghi này không?</b>";
  var msgSuccess = "<b>Bạn đã xóa thành công ''" + titleItem + "''</b>";
  jConfirm(msg, 'Thông báo', function (r) {
    if (r) {
      $.post(WebsiteUrl + "cms/admin/Ajax/Items/DeleteItem.aspx", { "iid": iid }, function (result) {

        $("#Item-" + iid).slideUp();
        $("#DeleteItem").html(result);
        ThongBao('3000', msgSuccess);
      });
    }
  });
}

function DeleteListItems() {
  var msg = "<b>Bạn có chắc chắn muốn xóa các bản ghi này không?</b>";
  var msgSuccess = "<b>Bạn đã xóa thành công các bản ghi vừa chọn</b>";
  var alertMes = "";
  var id = "";
  jQuery(".content input[type=checkbox]").each(function () {
    if (this.checked) {
      id = this.id.substring(this.id.lastIndexOf("_") + 1);
      alertMes += id + ",";
    }
  });
  jConfirm(msg, 'Thông báo', function (r) {
    if (r) {
      $.post(WebsiteUrl + "cms/admin/Ajax/Items/DeleteListItems.aspx", { "listigid": alertMes }, function (result) {
        ThongBao('3000', msgSuccess);
      });
    }

    jQuery(".content input[type=checkbox]").each(function () {
      if (this.checked) {
        id = this.id.substring(this.id.lastIndexOf("_") + 1);
        $("#Item-" + id).slideUp();
      }
    });
  });
}

function DeleteRecItem(iid, titleItem, pic) {
  var msg = "<b>Bạn có chắc chắn muốn xóa bản ghi này không?</b>";
  var msgSuccess = "<b>Bạn đã xóa thành công ''" + titleItem + "''</b>";
  jConfirm(msg, 'Thông báo', function (r) {
    if (r) {
      $("#DeleteCate").html("");
      $.post(WebsiteUrl + "cms/admin/Ajax/Items/DeleteRecItem.aspx", { "iid": iid, "pic": pic }, function (result) {
        $("#Item-" + iid).slideUp();
        ThongBao('3000', msgSuccess);
      });
    }
  });
}

function DeleteRecListItems(pic) {
  var msg = "<b>Bạn có chắc chắn muốn xóa các bản ghi này không?</b>";
  var msgSuccess = "<b>Bạn đã xóa thành công các bản ghi vừa chọn</b>";
  var alertMes = "";
  var id = "";
  jQuery(".content input[type=checkbox]").each(function () {
    if (this.checked) {
      id = this.id.substring(this.id.lastIndexOf("_") + 1);
      alertMes += id + ",";
    }
  });

  jConfirm(msg, 'Thông báo', function (r) {
    if (r) {
      $.post(WebsiteUrl + "cms/admin/Ajax/Items/DeleteRecListItems.aspx", { "listigid": alertMes, "pic": pic }, function (result) {
        ThongBao('3000', msgSuccess);
      });
    }

    jQuery(".content input[type=checkbox]").each(function () {
      if (this.checked) {
        id = this.id.substring(this.id.lastIndexOf("_") + 1);
        $("#Item-" + id).slideUp();
      }
    });
  });
}

function RestoreItem(iid, titleItem) {
  var msg = "<b>Bạn có chắc chắn muốn khôi phục bản ghi này không?</b>";
  var msgSuccess = "Bạn đã khôi phục thành công '" + titleItem + "' ";

  jConfirm(msg, 'Thông báo', function (r) {
    if (r) {
      $.post(WebsiteUrl + "cms/admin/Ajax/Items/RestoreItem.aspx", { "iid": iid }, function (result) {
        $("#Item-" + iid).slideUp();
        ThongBao('3000', msgSuccess);
      });
    }
  });
}

function RestoreItem2(action, iid, titleItem) {
  var msg = "<b>Bạn có chắc chắn muốn khôi phục bản ghi này không?</b>";
  var msgSuccess = "Bạn đã khôi phục thành công '" + titleItem + "' ";

  if(action != "")
  {
    jConfirm(msg, 'Thông báo', function (r) {
      if (r) {
        $.post(WebsiteUrl + "cms/admin/Ajax/Items/RestoreItem.aspx", { "iid": iid, "action": action }, function (result) {
          $("#Item-" + iid).slideUp();
          ThongBao('3000', msgSuccess);
        });
      }
    });
  } else {
    jConfirm(msg, 'Thông báo', function (r) {
      if (r) {
        $.post(WebsiteUrl + "cms/admin/Ajax/Items/RestoreItem.aspx", { "iid": iid }, function (result) {
          $("#Item-" + iid).slideUp();
          ThongBao('3000', msgSuccess);
        });
      }
    });
  }
}

function CancelItem(iid, userId, uc) {
  jPrompt('Để lại lời nhắn tới người đăng bài:', '', 'Thông báo', function (r) {
    if (r) {
      $.post(WebsiteUrl + "cms/admin/Ajax/Items/CancelItem.aspx", { "iid": iid, "userId": iid, "uc": uc, "content": r }, function (result) {
        $("#Item-" + iid).slideUp();
        ThongBao('3000', 'Hủy bài viết thành công!');
      });
    }
  });
}

function CancelItemAdv(iid, userId, uc) {
  jPrompt('Để lại lời nhắn tới người đăng bài:', '', 'Thông báo', function (r) {
    if (r) {
      $.post(WebsiteUrl + "cms/admin/Ajax/Items/CancelItem.aspx", { "iid": iid, "userId": iid, "uc": uc, "content": r }, function (result) {
        $("#Item-" + iid).slideUp();
        ThongBao('3000', 'Hủy quảng cáo thành công!');
      });
    }
  });
}