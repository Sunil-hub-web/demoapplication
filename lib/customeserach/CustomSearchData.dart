class CustomSearchData {
  String? kind;
  Url? url;
  Queries? queries;
  Context? context;
  SearchInformation? searchInformation;
  List<Items>? items;

  CustomSearchData({this.kind,
      this.url,
      this.queries,
      this.context,
      this.searchInformation,
      this.items});

  CustomSearchData.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    url = json['url'] != null ? new Url.fromJson(json['url']) : null;
    queries =
        json['queries'] != null ? new Queries.fromJson(json['queries']) : null;
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
    searchInformation = json['searchInformation'] != null
        ? new SearchInformation.fromJson(json['searchInformation'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.url != null) {
      data['url'] = this.url!.toJson();
    }
    if (this.queries != null) {
      data['queries'] = this.queries!.toJson();
    }
    if (this.context != null) {
      data['context'] = this.context!.toJson();
    }
    if (this.searchInformation != null) {
      data['searchInformation'] = this.searchInformation!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Url {
  String? type;
  String? template;

  Url({this.type, this.template});

  Url.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    template = json['template'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['template'] = this.template;
    return data;
  }
}

class Queries {
  List<Request>? request;
 // List<NextPage>? nextPage;

  Queries({this.request, /*this.nextPage*/});

  Queries.fromJson(Map<String, dynamic> json) {
    if (json['request'] != null) {
      request = <Request>[];
      json['request'].forEach((v) {
        request!.add(new Request.fromJson(v));
      });
    }
   /* if (json['nextPage'] != null) {
      nextPage = <NextPage>[];
      json['nextPage'].forEach((v) {
        nextPage!.add(new NextPage.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.map((v) => v.toJson()).toList();
    }
   /* if (this.nextPage != null) {
      data['nextPage'] = this.nextPage!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Request {
  String? title;
  String? totalResults;
  String? searchTerms;
  int? count;
  int? startIndex;
  String? inputEncoding;
  String? outputEncoding;
  String? safe;
  String? cx;

  Request(
      {this.title,
      this.totalResults,
      this.searchTerms,
      this.count,
      this.startIndex,
      this.inputEncoding,
      this.outputEncoding,
      this.safe,
      this.cx});

  Request.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    totalResults = json['totalResults'];
    searchTerms = json['searchTerms'];
    count = json['count'];
    startIndex = json['startIndex'];
    inputEncoding = json['inputEncoding'];
    outputEncoding = json['outputEncoding'];
    safe = json['safe'];
    cx = json['cx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['totalResults'] = this.totalResults;
    data['searchTerms'] = this.searchTerms;
    data['count'] = this.count;
    data['startIndex'] = this.startIndex;
    data['inputEncoding'] = this.inputEncoding;
    data['outputEncoding'] = this.outputEncoding;
    data['safe'] = this.safe;
    data['cx'] = this.cx;
    return data;
  }
}

class Context {
  String? title;

  Context({this.title});

  Context.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

class SearchInformation {
  double? searchTime;
  String? formattedSearchTime;
  String? totalResults;
  String? formattedTotalResults;

  SearchInformation(
      {this.searchTime,
      this.formattedSearchTime,
      this.totalResults,
      this.formattedTotalResults});

  SearchInformation.fromJson(Map<String, dynamic> json) {
    searchTime = json['searchTime'];
    formattedSearchTime = json['formattedSearchTime'];
    totalResults = json['totalResults'];
    formattedTotalResults = json['formattedTotalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchTime'] = this.searchTime;
    data['formattedSearchTime'] = this.formattedSearchTime;
    data['totalResults'] = this.totalResults;
    data['formattedTotalResults'] = this.formattedTotalResults;
    return data;
  }
}

class Items {
  String? kind;
  String? title;
  String? htmlTitle;
  String? link;
  String? displayLink;
  String? snippet;
  String? htmlSnippet;
  String? cacheId;
  String? formattedUrl;
  String? htmlFormattedUrl;
  Pagemap? pagemap;

  Items(
      {this.kind,
      this.title,
      this.htmlTitle,
      this.link,
      this.displayLink,
      this.snippet,
      this.htmlSnippet,
      this.cacheId,
      this.formattedUrl,
      this.htmlFormattedUrl,
      this.pagemap});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    title = json['title'];
    htmlTitle = json['htmlTitle'];
    link = json['link'];
    displayLink = json['displayLink'];
    snippet = json['snippet'];
    htmlSnippet = json['htmlSnippet'];
    cacheId = json['cacheId'];
    formattedUrl = json['formattedUrl'];
    htmlFormattedUrl = json['htmlFormattedUrl'];
    pagemap =
        json['pagemap'] != null ? new Pagemap.fromJson(json['pagemap']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['title'] = this.title;
    data['htmlTitle'] = this.htmlTitle;
    data['link'] = this.link;
    data['displayLink'] = this.displayLink;
    data['snippet'] = this.snippet;
    data['htmlSnippet'] = this.htmlSnippet;
    data['cacheId'] = this.cacheId;
    data['formattedUrl'] = this.formattedUrl;
    data['htmlFormattedUrl'] = this.htmlFormattedUrl;
    if (this.pagemap != null) {
      data['pagemap'] = this.pagemap!.toJson();
    }
    return data;
  }
}

class Pagemap {
  List<CseThumbnail>? cseThumbnail;
  List<Metatags>? metatags;
  List<CseImage>? cseImage;

  Pagemap({this.cseThumbnail, this.metatags, this.cseImage});

  Pagemap.fromJson(Map<String, dynamic> json) {
    if (json['cse_thumbnail'] != null) {
      cseThumbnail = <CseThumbnail>[];
      json['cse_thumbnail'].forEach((v) {
        cseThumbnail!.add(new CseThumbnail.fromJson(v));
      });
    }
    if (json['metatags'] != null) {
      metatags = <Metatags>[];
      json['metatags'].forEach((v) {
        metatags!.add(new Metatags.fromJson(v));
      });
    }
    if (json['cse_image'] != null) {
      cseImage = <CseImage>[];
      json['cse_image'].forEach((v) {
        cseImage!.add(new CseImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cseThumbnail != null) {
      data['cse_thumbnail'] =
          this.cseThumbnail!.map((v) => v.toJson()).toList();
    }
    if (this.metatags != null) {
      data['metatags'] = this.metatags!.map((v) => v.toJson()).toList();
    }
    if (this.cseImage != null) {
      data['cse_image'] = this.cseImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CseThumbnail {
  String? src;
  String? width;
  String? height;

  CseThumbnail({this.src, this.width, this.height});

  CseThumbnail.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Metatags {
  String? applicationName;
  String? msapplicationTilecolor;
  String? ogImage;
  String? ogType;
  String? ogSiteName;
  String? handheldfriendly;
  String? msapplicationTooltip;
  String? appleMobileWebAppTitle;
  String? ogTitle;
  String? msapplicationTileimage;
  String? msapplicationNavbuttonColor;
  String? ogDescription;
  String? ogImageSecureUrl;
  String? appleMobileWebAppStatusBarStyle;
  String? viewport;
  String? appleMobileWebAppCapable;
  String? ogUrl;
  String? formatDetection;
  String? ogImageWidth;
  String? themeColor;
  String? ogImageHeight;
  String? ogImageType;
  String? referrer;
  String? ogImageAlt;
  String? appleItunesApp;
  String? fbProfileId;
  String? twitterCard;
  String? twitterTitle;
  String? twitterImage;
  String? nextHeadCount;
  String? fbAppId;
  String? twitterSite;
  String? twitterDescription;
  String? ogRichAttachment;
  String? availablelanguages;
  String? defaultlanguage;

  Metatags(
      {this.applicationName,
      this.msapplicationTilecolor,
      this.ogImage,
      this.ogType,
      this.ogSiteName,
      this.handheldfriendly,
      this.msapplicationTooltip,
      this.appleMobileWebAppTitle,
      this.ogTitle,
      this.msapplicationTileimage,
      this.msapplicationNavbuttonColor,
      this.ogDescription,
      this.ogImageSecureUrl,
      this.appleMobileWebAppStatusBarStyle,
      this.viewport,
      this.appleMobileWebAppCapable,
      this.ogUrl,
      this.formatDetection,
      this.ogImageWidth,
      this.themeColor,
      this.ogImageHeight,
      this.ogImageType,
      this.referrer,
      this.ogImageAlt,
      this.appleItunesApp,
      this.fbProfileId,
      this.twitterCard,
      this.twitterTitle,
      this.twitterImage,
      this.nextHeadCount,
      this.fbAppId,
      this.twitterSite,
      this.twitterDescription,
      this.ogRichAttachment,
      this.availablelanguages,
      this.defaultlanguage});

  Metatags.fromJson(Map<String, dynamic> json) {
    applicationName = json['application-name'];
    msapplicationTilecolor = json['msapplication-tilecolor'];
    ogImage = json['og:image'];
    ogType = json['og:type'];
    ogSiteName = json['og:site_name'];
    handheldfriendly = json['handheldfriendly'];
    msapplicationTooltip = json['msapplication-tooltip'];
    appleMobileWebAppTitle = json['apple-mobile-web-app-title'];
    ogTitle = json['og:title'];
    msapplicationTileimage = json['msapplication-tileimage'];
    msapplicationNavbuttonColor = json['msapplication-navbutton-color'];
    ogDescription = json['og:description'];
    ogImageSecureUrl = json['og:image:secure_url'];
    appleMobileWebAppStatusBarStyle =
        json['apple-mobile-web-app-status-bar-style'];
    viewport = json['viewport'];
    appleMobileWebAppCapable = json['apple-mobile-web-app-capable'];
    ogUrl = json['og:url'];
    formatDetection = json['format-detection'];
    ogImageWidth = json['og:image:width'];
    themeColor = json['theme-color'];
    ogImageHeight = json['og:image:height'];
    ogImageType = json['og:image:type'];
    referrer = json['referrer'];
    ogImageAlt = json['og:image:alt'];
    appleItunesApp = json['apple-itunes-app'];
    fbProfileId = json['fb:profile_id'];
    twitterCard = json['twitter:card'];
    twitterTitle = json['twitter:title'];
    twitterImage = json['twitter:image'];
    nextHeadCount = json['next-head-count'];
    fbAppId = json['fb:app_id'];
    twitterSite = json['twitter:site'];
    twitterDescription = json['twitter:description'];
    ogRichAttachment = json['og:rich_attachment'];
    availablelanguages = json['availablelanguages'];
    defaultlanguage = json['defaultlanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['application-name'] = this.applicationName;
    data['msapplication-tilecolor'] = this.msapplicationTilecolor;
    data['og:image'] = this.ogImage;
    data['og:type'] = this.ogType;
    data['og:site_name'] = this.ogSiteName;
    data['handheldfriendly'] = this.handheldfriendly;
    data['msapplication-tooltip'] = this.msapplicationTooltip;
    data['apple-mobile-web-app-title'] = this.appleMobileWebAppTitle;
    data['og:title'] = this.ogTitle;
    data['msapplication-tileimage'] = this.msapplicationTileimage;
    data['msapplication-navbutton-color'] = this.msapplicationNavbuttonColor;
    data['og:description'] = this.ogDescription;
    data['og:image:secure_url'] = this.ogImageSecureUrl;
    data['apple-mobile-web-app-status-bar-style'] =
        this.appleMobileWebAppStatusBarStyle;
    data['viewport'] = this.viewport;
    data['apple-mobile-web-app-capable'] = this.appleMobileWebAppCapable;
    data['og:url'] = this.ogUrl;
    data['format-detection'] = this.formatDetection;
    data['og:image:width'] = this.ogImageWidth;
    data['theme-color'] = this.themeColor;
    data['og:image:height'] = this.ogImageHeight;
    data['og:image:type'] = this.ogImageType;
    data['referrer'] = this.referrer;
    data['og:image:alt'] = this.ogImageAlt;
    data['apple-itunes-app'] = this.appleItunesApp;
    data['fb:profile_id'] = this.fbProfileId;
    data['twitter:card'] = this.twitterCard;
    data['twitter:title'] = this.twitterTitle;
    data['twitter:image'] = this.twitterImage;
    data['next-head-count'] = this.nextHeadCount;
    data['fb:app_id'] = this.fbAppId;
    data['twitter:site'] = this.twitterSite;
    data['twitter:description'] = this.twitterDescription;
    data['og:rich_attachment'] = this.ogRichAttachment;
    data['availablelanguages'] = this.availablelanguages;
    data['defaultlanguage'] = this.defaultlanguage;
    return data;
  }
}

class CseImage {
  String? src;

  CseImage({this.src});

  CseImage.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    return data;
  }
}