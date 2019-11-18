using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TatThanhJsc.Extension;

/// <summary>
/// Summary description for TagExtension
/// </summary>
public class TagExtension
{
  /// <summary>
  /// Tác các thẻ tag theo dấu ,
  /// </summary>
  /// <param name="listag"></param>
  /// <returns></returns>
  public static string GetTag(string listag, string rewrite)
  {
    string s = "";
    foreach (string tag in listag.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries))
    {
      if (tag.Trim().Length > 0)
        s += "<a href='" + TatThanhJsc.Extension.UrlExtension.WebisteUrl + rewrite + "/tag/" +
             StringExtension.ReplateTitle(tag) + "'>" + tag.Trim() + "</a>, ";
    }
    if (s.Length > 0)
      s = s.Remove(s.Length - ", ".Length);
    return s;
  }
}