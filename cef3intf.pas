(*
 *                       Free Pascal Chromium Embedded 3
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Author: dliw <dev.dliw@gmail.com>
 * Repository: http://github.com/dliw/fpCEF3
 *
 * Based on 'Delphi Chromium Embedded' by: Henri Gourvest <hgourvest@gmail.com>
 *
 * Embarcadero Technologies, Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 *)

Unit cef3intf;

{$MODE objfpc}{$H+}

{$I cef.inc}

Interface

Uses
  Classes,
  cef3api, cef3types;

Type
  ICefBase = interface;

  ICefApp = interface;

  ICefAuthCallback = interface;

  ICefBrowser = interface;
  ICefRunFileDialogCallback = interface;
  ICefNavigationEntryVisior = interface;
  ICefPdfPrintCallback = interface;
  ICefBrowserHost = interface;

  ICefBrowserProcessHandler = interface;

  ICefCompletionCallback = interface;
  ICefCallback = interface;

  ICefClient = interface;

  ICefCommandLine = interface;

  ICefRunContextMenuCallback = interface;
  ICefContextMenuHandler = interface;
  ICefContextMenuParams = interface;

  ICefCookieManager = interface;
  ICefCookieVisitor = interface;
  ICefSetCookieCallback = interface;
  ICefDeleteCookiesCallback = interface;

  ICefFileDialogCallback = interface;
  ICefDialogHandler = interface;

  ICefDisplayHandler = interface;

  ICefDomVisitor = interface;
  ICefDomDocument = interface;
  ICefDomNode = interface;

  ICefBeforeDownloadCallback = interface;
  ICefDownloadItemCallback = interface;
  ICefDownloadHandler = interface;

  ICefDownloadItem = interface;

  ICefDragData = interface;

  ICefDragHandler = interface;

  ICefFindHandler = interface;

  ICefFocusHandler = interface;

  ICefFrame = interface;

  ICefGetGeolocationCallback = interface;

  ICefGeolocationCallback = interface;
  ICefGeolocationHandler = interface;

  ICefJsDialogCallback = interface;
  ICefJsDialogHandler = interface;

  ICefKeyboardHandler = interface;

  ICefLifeSpanHandler = interface;

  ICefLoadHandler = interface;

  ICefMenuModel = interface;

  ICefNavigationEntry = interface;

  ICefPrintDialogCallback = interface;
  ICefPrintJobCallback = interface;
  ICefPrintHandler = interface;

  ICefPrintSettings = interface;

  ICefProcessMessage = interface;

  ICefRenderHandler = interface;

  ICefRenderProcessHandler = interface;

  ICefRequest = interface;

  ICefPostData = interface;
  ICefPostDataElement = interface;

  ICefRequestContext = interface;

  ICefRequestContextHandler = interface;

  ICefRequestCallback = interface;
  ICefRequestHandler = interface;

  ICefResourceBundle = interface;

  ICefResourceBundleHandler = interface;

  ICefResourceHandler = interface;

  ICefResponse = interface;

  ICefResponseFilter = interface;

  ICefSchemeRegistrar = interface;
  ICefSchemeHandlerFactory = interface;

  ICefSslcertPrincipal = interface;
  ICefSslinfo = interface;

  ICefReadHandler = interface;
  ICefStreamReader = interface;
  ICefWriteHandler = interface;
  ICefStreamWriter = interface;

  ICefStringVisitor = interface;

  ICefTask = interface;
  ICefTaskRunner = interface;

  ICefEndTracingCallback = interface;

  ICefUrlRequest = interface;

  ICefUrlRequestClient = interface;

  ICefV8Context = interface;
  ICefV8Handler = interface;
  ICefV8Accessor = interface;
  ICefV8Exception = interface;
  IPCefV8Value = ^PCefV8ValueArray;
  ICefV8Value = interface;
  ICefv8ValueArray = array of ICefv8Value;
  ICefV8StackTrace = interface;
  ICefV8StackFrame = interface;

  ICefValue = interface;
  ICefBinaryValue = interface;
  ICefBinaryValueArray = array of ICefBinaryValue;
  ICefDictionaryValue = interface;
  ICefListValue = interface;

  ICefWebPluginInfo = interface;
  ICefWebPluginInfoVisitor = interface;
  ICefWebPluginUnstableCallback = interface;

  ICefXMLReader = interface;

  ICefZipReader = interface;

  ICefStringMap = interface;
  ICefStringMultiMap = interface;

  // Callbacks
  TCefDomVisitorProc = procedure(const document: ICefDomDocument);
  TCefStringVisitorProc = procedure(const str: ustring);
  TCefCookieVisitorProc = function(const cookie: TCefCookie; count, total: Integer; out deleteCookie: Boolean): Boolean;
  TOnRegisterCustomSchemes = procedure(const registrar: ICefSchemeRegistrar);
  TOnBeforeCommandLineProcessing = procedure(const processType: ustring; const commandLine: ICefCommandLine);
  TCefWebPluginInfoVisitorProc = function(const info: ICefWebPluginInfo; count, total: Integer): Boolean;
  TCefV8AccessorGetterProc = function(const name: ustring; const obj: ICefv8Value; out value: ICefv8Value; const exception: string): Boolean;
  TCefV8AccessorSetterProc = function(const name: ustring; const obj, value: ICefv8Value; const exception: string): Boolean;
  TCefRunFileDialogCallbackProc = procedure(selectedAcceptFilter: Integer; filePaths: TStrings);

  ICefBase = interface ['{1F9A7B44-DCDC-4477-9180-3ADD44BDEB7B}']
    function Wrap: Pointer;
  end;

  ICefApp = interface(ICefBase) ['{970CA670-9070-4642-B188-7D8A22DAEED4}']
    procedure OnBeforeCommandLineProcessing(const processType: ustring; const commandLine: ICefCommandLine);
    procedure OnRegisterCustomSchemes(const registrar: ICefSchemeRegistrar);
    function GetResourceBundleHandler: ICefResourceBundleHandler;
    function GetBrowserProcessHandler: ICefBrowserProcessHandler;
    function GetRenderProcessHandler: ICefRenderProcessHandler;
  end;

  ICefAuthCallback = interface(ICefBase) ['{500C2023-BF4D-4FF7-9C04-165E5C389131}']
    procedure Cont(const username, password: ustring);
    procedure Cancel;
  end;

  ICefBrowser = interface(ICefBase) ['{BA003C2E-CF15-458F-9D4A-FE3CEFCF3EEF}']
    function GetHost: ICefBrowserHost;
    function CanGoBack: Boolean;
    procedure GoBack;
    function CanGoForward: Boolean;
    procedure GoForward;
    function IsLoading: Boolean;
    procedure Reload;
    procedure ReloadIgnoreCache;
    procedure StopLoad;
    function GetIdentifier: Integer;
    function IsSame(const that: ICefBrowser): Boolean;
    function IsPopup: Boolean;
    function HasDocument: Boolean;
    function GetMainFrame: ICefFrame;
    function GetFocusedFrame: ICefFrame;
    function GetFrameByident(identifier: Int64): ICefFrame;
    function GetFrame(const name: ustring): ICefFrame;
    function GetFrameCount: TSize;
    procedure GetFrameIdentifiers(count: PSize; identifiers: PInt64);
    procedure GetFrameNames(names: TStrings);
    function SendProcessMessage(targetProcess: TCefProcessId; message: ICefProcessMessage): Boolean;

    property MainFrame: ICefFrame read GetMainFrame;
    property FocusedFrame: ICefFrame read GetFocusedFrame;
    property FrameCount: TSize read GetFrameCount;
    property Host: ICefBrowserHost read GetHost;
    property Identifier: Integer read GetIdentifier;
  end;

  ICefRunFileDialogCallback = interface(ICefBase) ['{59FCECC6-E897-45BA-873B-F09586C4BE47}']
    procedure OnFileDialogDismissed(selectedAcceptFilter: Integer; filePaths: TStrings);
  end;

  ICefNavigationEntryVisior = interface(ICefBase) ['{ABD07D78-45BA-44B0-8D2A-CB52D350F492}']
    function Visit(entry: ICefNavigationEntry; current, index, total: Integer): Boolean;
  end;

  ICefPdfPrintCallback = interface(ICefBase) ['{54A65CF4-4419-4D51-A59B-256FEE855436}']
    procedure OnPdfPrintFinished(const path: ustring; ok: Boolean);
  end;

  ICefBrowserHost = interface(ICefBase) ['{53AE02FF-EF5D-48C3-A43E-069DA9535424}']
    function GetBrowser: ICefBrowser;
    procedure CloseBrowser(aForceClose: Boolean);
    procedure SetFocus(focus: Boolean);
    procedure SetWindowVisibility(visible: Boolean);
    function GetWindowHandle: TCefWindowHandle;
    function GetOpenerWindowHandle: TCefWindowHandle;
    function GetClient: ICefClient;
    function GetRequestContext: ICefRequestContext;
    function GetZoomLevel: Double;
    procedure SetZoomLevel(zoomLevel: Double);
    procedure RunFileDialog(mode: TCefFileDialogMode; const title, defaultFileName: ustring;
      acceptFilters: TStrings; selectedAcceptFilter: Integer; const callback: ICefRunFileDialogCallback);
    procedure StartDownload(const url: ustring);
    procedure Print;
    procedure PrintToPdf(const path: ustring; const settings: TCefPdfPrintSettings; callback: ICefPdfPrintCallback);
    procedure Find(identifier: Integer; const searchText: ustring; forward_, matchCase, findNext: Boolean);
    procedure StopFinding(clearSelection: Boolean);
    procedure ShowDevTools(var windowInfo: TCefWindowInfo; client: ICefClient;
      var settings: TCefBrowserSettings; const inspectElementAt: PCefPoint);
    procedure CloseDevTools;
    procedure GetNavigationEntries(visitor: ICefNavigationEntryVisior; currentOnly: Boolean);
    procedure SetMouseCursorChangeDisabled(disabled: Boolean);
    function GetIsMouseCursorChangeDisabled: Boolean;
    procedure ReplaceMisspelling(const word: ustring);
    procedure AddWordToDictionary(const word: ustring);
    function GetIsWindowRenderingDisabled: Boolean;
    procedure WasResized;
    procedure WasHidden(hidden: Boolean);
    procedure NotifyScreenInfoChanged;
    procedure Invalidate(const aType: TCefPaintElementType);
    procedure SendKeyEvent(const event: TCefKeyEvent);
    procedure SendMouseClickEvent(const event: TCefMouseEvent; aType: TCefMouseButtonType;
      mouseUp: Boolean; clickCount: Integer);
    procedure SendMouseMoveEvent(event:TCefMouseEvent; mouseLeave: Boolean);
    procedure SendMouseWheelEvent(const event: TCefMouseEvent; deltaX, deltaY: Integer);
    procedure SendFocusEvent(dosetFocus: Integer);
    procedure SendCaptureLostEvent;
    procedure NotifyMoveOrResizeStarted;
    function GetWindowlessFrameRate: Integer;
    procedure SetWindowlessFrameRate(frameRate: Integer);
    {$IFDEF DARWIN}
      function GetNstextInputContext: ICefTextInputContext;
      procedure HandleKeyEventBeforeTextInputClient(event: TCefEventHandle);
      procedure HandleKeyAfterBeforeTextInputClient(event: TCefEventHandle);
    {$ENDIF}
    procedure DragTargetDragEnter(dragData: ICefDragData; const event: TCefMouseEvent; allowedOps: TCefDragOperationsMask);
    procedure DragTargetDragOver(const event: TCefMouseEvent; allowedOps: TCefDragOperationsMask);
    procedure DragTargetDragLeave;
    procedure DragTargetDrop(const event: TCefMouseEvent);
    procedure DragSourceEndedAt(x,y: Integer; op: TCefDragOperationsMask);
    procedure DragSourceSystemDragEnded;

    property Browser: ICefBrowser read GetBrowser;
    property WindowHandle: TCefWindowHandle read GetWindowHandle;
    property OpenerWindowHandle: TCefWindowHandle read GetOpenerWindowHandle;
    property Client: ICefClient read GetClient;
    property ZoomLevel: Double read GetZoomLevel write SetZoomLevel;
    property IsMouseCursorChangeDisabled: Boolean read GetIsMouseCursorChangeDisabled;
    property IsWindowRenderingDisabled: Boolean read GetIsWindowRenderingDisabled;
  end;

  ICefBrowserProcessHandler = interface(ICefBase) ['{27291B7A-C0AE-4EE0-9115-15C810E22F6C}']
    procedure OnContextInitialized;
    procedure OnBeforeChildProcessLaunch(const commandLine: ICefCommandLine);
    procedure OnRenderProcessThreadCreated(extraInfo:ICefListValue);
    function GetPrintHandler: ICefPrintHandler;
  end;

  ICefCompletionCallback = interface(ICefBase) ['{F0B6A26E-BACF-4FB9-B487-D24F632849F8}']
    procedure OnComplete;
  end;

  ICefCallback = interface(ICefBase) ['{1B8C449F-E2D6-4B78-9BBA-6F47E8BCDF37}']
    procedure Cont;
    procedure Cancel;
  end;

  ICefClient = interface(ICefBase) ['{1D502075-2FF0-4E13-A112-9E541CD811F4}']
    function GetContextMenuHandler: ICefContextMenuHandler;
    function GetDialogHandler:ICefDialogHandler;
    function GetDisplayHandler: ICefDisplayHandler;
    function GetDownloadHandler: ICefDownloadHandler;
    function GetDragHandler: ICefDragHandler;
    function GetFindHandler: ICefFindHandler;
    function GetFocusHandler: ICefFocusHandler;
    function GetGeolocationHandler: ICefGeolocationHandler;
    function GetJsdialogHandler: ICefJsdialogHandler;
    function GetKeyboardHandler: ICefKeyboardHandler;
    function GetLifeSpanHandler: ICefLifeSpanHandler;
    function GetLoadHandler: ICefLoadHandler;
    function GetRenderHandler: ICefRenderHandler;
    function GetRequestHandler: ICefRequestHandler;
    function OnProcessMessageReceived(const browser: ICefBrowser; sourceProcess: TCefProcessId;
      const message: ICefProcessMessage): Boolean;
  end;

  ICefCommandLine = interface(ICefBase) ['{6B43D21B-0F2C-4B94-B4E6-4AF0D7669D8E}']
    function IsValid: Boolean;
    function IsReadOnly: Boolean;
    function Copy: ICefCommandLine;
    procedure InitFromArgv(argc: Integer; const argv: PPAnsiChar);
    procedure InitFromString(const commandLine: ustring);
    procedure Reset;
    procedure GetArgv(argv: TStrings);
    function GetCommandLineString: ustring;
    function GetProgram: ustring;
    procedure SetProgram(const program_: ustring);
    function HasSwitches: Boolean;
    function HasSwitch(const name: ustring): Boolean;
    function GetSwitchValue(const name: ustring): ustring;
    procedure GetSwitches(switches: ICefStringMap);
    procedure AppendSwitch(const name: ustring);
    procedure AppendSwitchWithValue(const name, value: ustring);
    function HasArguments: Boolean;
    procedure GetArguments(arguments: TStrings);
    procedure AppendArgument(const argument: ustring);
    procedure PrependWrapper(const wrapper: ustring);
  end;

  ICefRunContextMenuCallback = interface(ICefBase) ['{E29CE5F3-44D9-4E62-9BDE-DC4CC53948C9}']
    procedure Cont(commandId: Integer; eventFlags: TCefEventFlags);
    procedure Cancel;
  end;

  ICefContextMenuHandler = interface(ICefBase) ['{C2951895-4087-49D5-BA18-4D9BA4F5EDD7}']
    procedure OnBeforeContextMenu(const browser: ICefBrowser; const frame: ICefFrame;
      const params: ICefContextMenuParams; const model: ICefMenuModel);
    function RunContextMenu(const browser: ICefBrowser; const frame: ICefFrame;
      const params: ICefContextMenuParams; const model: ICefMenuModel;
      const callback: ICefRunContextMenuCallback): Boolean;
    function OnContextMenuCommand(const browser: ICefBrowser; const frame: ICefFrame;
      const params: ICefContextMenuParams; commandId: Integer;
      eventFlags: TCefEventFlags): Boolean;
    procedure OnContextMenuDismissed(const browser: ICefBrowser; const frame: ICefFrame);
  end;

  ICefContextMenuParams = interface(ICefBase) ['{E31BFA9E-D4E2-49B7-A05D-20018C8794EB}']
    function GetXCoord: Integer;
    function GetYCoord: Integer;
    function GetTypeFlags: TCefContextMenuTypeFlags;
    function GetLinkUrl: ustring;
    function GetUnfilteredLinkUrl: ustring;
    function GetSourceUrl: ustring;
    function HasImageContents: Boolean;
    function GetPageUrl: ustring;
    function GetFrameUrl: ustring;
    function GetFrameCharset: ustring;
    function GetMediaType: TCefContextMenuMediaType;
    function GetMediaStateFlags: TCefContextMenuMediaStateFlags;
    function GetSelectionText: ustring;
    function GetMisspelledWord: ustring;
    function GetDictionarySuggestions(suggenstions: TStrings): Boolean;
    function IsEditable: Boolean;
    function IsSpellCheckEnabled: Boolean;
    function GetEditStateFlags: TCefContextMenuEditStateFlags;
    function IsCustomMenu: Boolean;
    function IsPepperMenu: Boolean;

    property XCoord: Integer read GetXCoord;
    property YCoord: Integer read GetYCoord;
    property TypeFlags: TCefContextMenuTypeFlags read GetTypeFlags;
    property LinkUrl: ustring read GetLinkUrl;
    property UnfilteredLinkUrl: ustring read GetUnfilteredLinkUrl;
    property SourceUrl: ustring read GetSourceUrl;
    property PageUrl: ustring read GetPageUrl;
    property FrameUrl: ustring read GetFrameUrl;
    property FrameCharset: ustring read GetFrameCharset;
    property MediaType: TCefContextMenuMediaType read GetMediaType;
    property MediaStateFlags: TCefContextMenuMediaStateFlags read GetMediaStateFlags;
    property SelectionText: ustring read GetSelectionText;
    property EditStateFlags: TCefContextMenuEditStateFlags read GetEditStateFlags;
  end;

  ICefCookieManager = Interface(ICefBase) ['{CC1749E6-9AD3-4283-8430-AF6CBF3E8785}']
    procedure SetSupportedSchemes(schemes: TStrings; callback: ICefCompletionCallback);
    function VisitAllCookies(const visitor: ICefCookieVisitor): Boolean;
    function VisitAllCookiesProc(const visitor: TCefCookieVisitorProc): Boolean;
    function VisitUrlCookies(const url: ustring;
      includeHttpOnly: Boolean; const visitor: ICefCookieVisitor): Boolean;
    function VisitUrlCookiesProc(const url: ustring;
      includeHttpOnly: Boolean; const visitor: TCefCookieVisitorProc): Boolean;
    function SetCookie(const url: ustring; const name, value, domain, path: ustring; secure, httponly,
      hasExpires: Boolean; const creation, lastAccess, expires: TDateTime;
      callback: ICefSetCookieCallback): Boolean;
    function DeleteCookies(const url, cookieName: ustring; callback: ICefDeleteCookiesCallback): Boolean;
    function SetStoragePath(const path: ustring; PersistSessionCookies: Boolean;
      callback: ICefCompletionCallback): Boolean;
    function FlushStore(handler: ICefCompletionCallback): Boolean;
  end;

  ICefCookieVisitor = interface(ICefBase) ['{8378CF1B-84AB-4FDB-9B86-34DDABCCC402}']
    function Visit(const cookie: TCefCookie; count, total: Integer; out deleteCookie: Boolean): Boolean;
  end;

  ICefSetCookieCallback = interface(ICefBase) ['{99F7638C-1249-410C-A825-916EB15F474D}']
    procedure OnComplete(success: Boolean);
  end;

  ICefDeleteCookiesCallback = interface(ICefBase) ['{375F4D3D-A028-4E1F-80B9-EBA4DA556D1A}']
    procedure OnComplete(numDeleted: Integer);
  end;

  ICefFileDialogCallBack = interface(ICefBase) ['{F5F75E88-4BEC-4BE3-B179-DC5C6DFDAA84}']
    procedure Cont(selectedAcceptFilter: Integer; filePaths: TStrings);
    procedure Cancel;
  end;

  ICefDialogHandler = interface(ICefBase) ['{07386301-A6AB-4599-873E-8D89545CB39F}']
    function OnFileDialog(const browser: ICefBrowser; mode: TCefFileDialogMode;
      const title, defaultFileName: ustring; acceptFilters: TStrings; selectedAcceptFilter: Integer;
      const callback: ICefFileDialogCallback): Boolean;
  end;

  ICefDisplayHandler = interface(ICefBase) ['{1EC7C76D-6969-41D1-B26D-079BCFF054C4}']
    procedure OnAddressChange(const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
    procedure OnTitleChange(const browser: ICefBrowser; const title: ustring);
    procedure OnFaviconUrlchange(const browser: ICefBrowser; iconUrls: TStrings);
    procedure OnFullscreenModeChange(const browser: ICefBrowser; fullscreen: Boolean);
    function OnTooltip(const browser: ICefBrowser; var text: ustring): Boolean;
    procedure OnStatusMessage(const browser: ICefBrowser; const value: ustring);
    function OnConsoleMessage(const browser: ICefBrowser; const message, source: ustring; line: Integer): Boolean;
  end;

  ICefDomVisitor = interface(ICefBase) ['{30398428-3196-4531-B968-2DDBED36F6B0}']
    procedure Visit(const document: ICefDomDocument);
  end;

  ICefDomDocument = interface(ICefBase) ['{08E74052-45AF-4F69-A578-98A5C3959426}']
    function GetType: TCefDomDocumentType;
    function GetDocument: ICefDomNode;
    function GetBody: ICefDomNode;
    function GetHead: ICefDomNode;
    function GetTitle: ustring;
    function GetElementById(const id: ustring): ICefDomNode;
    function GetFocusedNode: ICefDomNode;
    function HasSelection: Boolean;
    function GetSelectionStartOffset: Integer;
    function GetSelectionEndOffset: Integer;
    function GetSelectionAsMarkup: ustring;
    function GetSelectionAsText: ustring;
    function GetBaseUrl: ustring;
    function GetCompleteUrl(const partialURL: ustring): ustring;

    property DocType: TCefDomDocumentType read GetType;
    property Document: ICefDomNode read GetDocument;
    property Body: ICefDomNode read GetBody;
    property Head: ICefDomNode read GetHead;
    property Title: ustring read GetTitle;
    property FocusedNode: ICefDomNode read GetFocusedNode;
    property SelectionStartOffset: Integer read GetSelectionStartOffset;
    property SelectionEndOffset: Integer read GetSelectionEndOffset;
    property SelectionAsMarkup: ustring read GetSelectionAsMarkup;
    property SelectionAsText: ustring read GetSelectionAsText;
    property BaseUrl: ustring read GetBaseUrl;
  end;

  ICefDomNode = interface(ICefBase) ['{96C03C9E-9C98-491A-8DAD-1947332232D6}']
    function GetType: TCefDomNodeType;
    function IsText: Boolean;
    function IsElement: Boolean;
    function IsEditable: Boolean;
    function IsFormControlElement: Boolean;
    function GetFormControlElementType: ustring;
    function IsSame(const that: ICefDomNode): Boolean;
    function GetName: ustring;
    function GetValue: ustring;
    function SetValue(const value: ustring): Boolean;
    function GetAsMarkup: ustring;
    function GetDocument: ICefDomDocument;
    function GetParent: ICefDomNode;
    function GetPreviousSibling: ICefDomNode;
    function GetNextSibling: ICefDomNode;
    function HasChildren: Boolean;
    function GetFirstChild: ICefDomNode;
    function GetLastChild: ICefDomNode;
    function GetElementTagName: ustring;
    function HasElementAttributes: Boolean;
    function HasElementAttribute(const attrName: ustring): Boolean;
    function GetElementAttribute(const attrName: ustring): ustring;
    procedure GetElementAttributes(const attrMap: ICefStringMap);
    function SetElementAttribute(const attrName, value: ustring): Boolean;
    function GetElementInnerText: ustring;

    property NodeType: TCefDomNodeType read GetType;
    property Name: ustring read GetName;
    property AsMarkup: ustring read GetAsMarkup;
    property Document: ICefDomDocument read GetDocument;
    property Parent: ICefDomNode read GetParent;
    property PreviousSibling: ICefDomNode read GetPreviousSibling;
    property NextSibling: ICefDomNode read GetNextSibling;
    property FirstChild: ICefDomNode read GetFirstChild;
    property LastChild: ICefDomNode read GetLastChild;
    property ElementTagName: ustring read GetElementTagName;
    property ElementInnerText: ustring read GetElementInnerText;
  end;

  ICefBeforeDownloadCallback = interface(ICefBase) ['{5A81AF75-CBA2-444D-AD8E-522160F36433}']
    procedure Cont(const downloadPath: ustring; showDialog: Boolean);
  end;

  ICefDownloadItemCallback = interface(ICefBase) ['{498F103F-BE64-4D5F-86B7-B37EC69E1735}']
    procedure Cancel;
    procedure Pause;
    procedure Resume;
  end;

  ICefDownloadHandler = interface(ICefBase) ['{3137F90A-5DC5-43C1-858D-A269F28EF4F1}']
    procedure OnBeforeDownload(const browser: ICefBrowser; const downloadItem: ICefDownloadItem;
      const suggestedName: ustring; const callback: ICefBeforeDownloadCallback);
    procedure OnDownloadUpdated(const browser: ICefBrowser; const downloadItem: ICefDownloadItem;
      const callback: ICefDownloadItemCallback);
  end;

  ICefDownloadItem = interface(ICefBase) ['{B34BD320-A82E-4185-8E84-B98E5EEC803F}']
    function IsValid: Boolean;
    function IsInProgress: Boolean;
    function IsComplete: Boolean;
    function IsCanceled: Boolean;
    function GetCurrentSpeed: Int64;
    function GetPercentComplete: Integer;
    function GetTotalBytes: Int64;
    function GetReceivedBytes: Int64;
    function GetStartTime: TDateTime;
    function GetEndTime: TDateTime;
    function GetFullPath: ustring;
    function GetId: UInt32;
    function GetUrl: ustring;
    function GetOriginalUrl: ustring;
    function GetSuggestedFileName: ustring;
    function GetContentDisposition: ustring;
    function GetMimeType: ustring;

    property CurrentSpeed: Int64 read GetCurrentSpeed;
    property PercentComplete: Integer read GetPercentComplete;
    property TotalBytes: Int64 read GetTotalBytes;
    property ReceivedBytes: Int64 read GetReceivedBytes;
    property StartTime: TDateTime read GetStartTime;
    property EndTime: TDateTime read GetEndTime;
    property FullPath: ustring read GetFullPath;
    property Id: UInt32 read GetId;
    property Url: ustring read GetUrl;
    property SuggestedFileName: ustring read GetSuggestedFileName;
    property ContentDisposition: ustring read GetContentDisposition;
    property MimeType: ustring read GetMimeType;
  end;

  ICefDragData = interface(ICefBase) ['{DD211D8A-E42D-48D4-B01F-2082A7DE0FCD}']
    function Clone: ICefDragData;
    function IsReadOnly: Boolean;
    function IsLink: Boolean;
    function IsFragment: Boolean;
    function IsFile: Boolean;
    function GetLinkUrl: ustring;
    function GetLinkTitle: ustring;
    function GetLinkMetadata: ustring;
    function GetFragmentText: ustring;
    function GetFragmentHTML: ustring;
    function GetFragmentBaseURL: ustring;
    function GetFileName: ustring;
    function GetFileContents(writer: ICefStreamWriter): TSize;
    function GetFileNames(names: TStrings): Boolean;
    procedure SetLinkUrl(const url: ustring);
    procedure SetLinkTitle(const title: ustring);
    procedure SetLinkMetadata(const data: ustring);
    procedure SetFragmentText(const text: ustring);
    procedure SetFragmentHtml(const html: ustring);
    procedure SetFragmentBaseUrl(const baseUrl: ustring);
    procedure ResetFileContents;
    procedure AddFile(const path, displayName: ustring);
  end;

  ICefDragHandler = interface(ICefBase) ['{FA58BA67-6D5B-48DE-A9AB-E39E424763B2}']
    function OnDragEnter(const browser: ICefBrowser; const dragData: ICefDragData; mask: TCefDragOperationsMask): Boolean;
    procedure OnDraggableRegionsChanged(browser: ICefBrowser; regionsCount: TSize; const regions: TCefDraggableRegionArray);
  end;

  ICefFindHandler = interface(ICefBase) ['{B2F30350-FB95-4017-AE85-CDD59BAC7FB3}']
    procedure OnFindResult(browser: ICefBrowser; identifier, count: Integer;
      const selectionRect: TCefRect; activeMatchOridinal: Integer; finalUpdate: Boolean);
  end;

  ICefFocusHandler = interface(ICefBase) ['{BB7FA3FA-7B1A-4ADC-8E50-12A24018DD90}']
    procedure OnTakeFocus(const browser: ICefBrowser; next: Boolean);
    function OnSetFocus(const browser: ICefBrowser; source: TCefFocusSource): Boolean;
    procedure OnGotFocus(const browser: ICefBrowser);
  end;

  ICefFrame = interface(ICefBase) ['{8FD3D3A6-EA3A-4A72-8501-0276BD5C3D1D}']
    function IsValid: Boolean;
    procedure Undo;
    procedure Redo;
    procedure Cut;
    procedure Copy;
    procedure Paste;
    procedure Del;
    procedure SelectAll;
    procedure ViewSource;
    procedure GetSource(const visitor: ICefStringVisitor);
    procedure GetSourceProc(const proc: TCefStringVisitorProc);
    procedure GetText(const visitor: ICefStringVisitor);
    procedure GetTextProc(const proc: TCefStringVisitorProc);
    procedure LoadRequest(const request: ICefRequest);
    procedure LoadUrl(const url: ustring);
    procedure LoadString(const str, url: ustring);
    procedure ExecuteJavaScript(const code, scriptUrl: ustring; startLine: Integer);
    function IsMain: Boolean;
    function IsFocused: Boolean;
    function GetName: ustring;
    function GetIdentifier: Int64;
    function GetParent: ICefFrame;
    function GetUrl: ustring;
    function GetBrowser: ICefBrowser;
    function GetV8Context: ICefv8Context;
    procedure VisitDom(const visitor: ICefDomVisitor);
    procedure VisitDomProc(const proc: TCefDomVisitorProc);

    property Name: ustring read GetName;
    property Url: ustring read GetUrl;
    property Browser: ICefBrowser read GetBrowser;
    property Parent: ICefFrame read GetParent;
  end;

  ICefGetGeolocationCallback = interface(ICefBase) ['{ACB82FD9-3FFD-43F9-BF1A-A4849BF5B814}']
    procedure OnLocationUpdate(const position: TCefGeoposition);
  end;

  ICefGeolocationCallback = interface(ICefBase) ['{272B8E4F-4AE4-4F14-BC4E-5924FA0C149D}']
    procedure Cont(allow: Boolean);
  end;

  ICefGeolocationHandler = interface(ICefBase) ['{1178EE62-BAE7-4E44-932B-EAAC7A18191C}']
    function OnRequestGeolocationPermission(const browser: ICefBrowser; const requestingUrl: ustring;
      requestId: Integer; const callback: ICefGeolocationCallback): Boolean;
    procedure OnCancelGeolocationPermission(const browser: ICefBrowser;
      const requestingUrl: ustring; requestId: Integer);
  end;

  ICefJsDialogCallback = interface(ICefBase) ['{187B2156-9947-4108-87AB-32E559E1B026}']
    procedure Cont(success: Boolean; const userInput: ustring);
  end;

  ICefJsDialogHandler = interface(ICefBase) ['{64E18F86-DAC5-4ED1-8589-44DE45B9DB56}']
    function OnJsdialog(const browser: ICefBrowser; const originUrl, acceptLang: ustring;
      dialogType: TCefJsDialogType; const messageText, defaultPromptText: ustring;
      callback: ICefJsDialogCallback; out suppressMessage: Boolean): Boolean;
    function OnBeforeUnloadDialog(const browser: ICefBrowser;
      const messageText: ustring; isReload: Boolean;
      const callback: ICefJsDialogCallback): Boolean;
    procedure OnResetDialogState(const browser: ICefBrowser);
    procedure OnDialogClosed(const browser: ICefBrowser);
  end;

  ICefKeyboardHandler = interface(ICefBase) ['{0512F4EC-ED88-44C9-90D3-5C6D03D3B146}']
    function OnPreKeyEvent(const browser: ICefBrowser; const event: PCefKeyEvent;
      osEvent: TCefEventHandle; out isKeyboardShortcut: Boolean): Boolean;
    function OnKeyEvent(const browser: ICefBrowser; const event: PCefKeyEvent;
      osEvent: TCefEventHandle): Boolean;
  end;

  ICefLifeSpanHandler = interface(ICefBase) ['{0A3EB782-A319-4C35-9B46-09B2834D7169}']
    function OnBeforePopup(const browser: ICefBrowser; const frame: ICefFrame;
      const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition;
      userGesture: Boolean; var popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var client: ICefClient; var settings: TCefBrowserSettings; var noJavascriptAccess: Boolean): Boolean;
    procedure OnAfterCreated(const browser: ICefBrowser);
    function RunModal(const browser: ICefBrowser): Boolean;
    function DoClose(const browser: ICefBrowser): Boolean;
    procedure OnBeforeClose(const browser: ICefBrowser);
  end;

  ICefLoadHandler = interface(ICefBase) ['{2C63FB82-345D-4A5B-9858-5AE7A85C9F49}']
    procedure OnLoadingStateChange(const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean);
    procedure OnLoadStart(const browser: ICefBrowser; const frame: ICefFrame);
    procedure OnLoadEnd(const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure OnLoadError(const browser: ICefBrowser; const frame: ICefFrame; errorCode: TCefErrorCode;
      const errorText, failedUrl: ustring);
  end;

  ICefMenuModel = interface(ICefBase) ['{40AF19D3-8B4E-44B8-8F89-DEB5907FC495}']
    function Clear: Boolean;
    function GetCount: Integer;
    function AddSeparator: Boolean;
    function AddItem(commandId: Integer; const text: ustring): Boolean;
    function AddCheckItem(commandId: Integer; const text: ustring): Boolean;
    function AddRadioItem(commandId: Integer; const text: ustring; groupId: Integer): Boolean;
    function AddSubMenu(commandId: Integer; const text: ustring): ICefMenuModel;
    function InsertSeparatorAt(index: Integer): Boolean;
    function InsertItemAt(index, commandId: Integer; const text: ustring): Boolean;
    function InsertCheckItemAt(index, commandId: Integer; const text: ustring): Boolean;
    function InsertRadioItemAt(index, commandId: Integer; const text: ustring; groupId: Integer): Boolean;
    function InsertSubMenuAt(index, commandId: Integer; const text: ustring): ICefMenuModel;
    function Remove(commandId: Integer): Boolean;
    function RemoveAt(index: Integer): Boolean;
    function GetIndexOf(commandId: Integer): Integer;
    function GetCommandIdAt(index: Integer): Integer;
    function SetCommandIdAt(index, commandId: Integer): Boolean;
    function GetLabel(commandId: Integer): ustring;
    function GetLabelAt(index: Integer): ustring;
    function SetLabel(commandId: Integer; const text: ustring): Boolean;
    function SetLabelAt(index: Integer; const text: ustring): Boolean;
    function GetType(commandId: Integer): TCefMenuItemType;
    function GetTypeAt(index: Integer): TCefMenuItemType;
    function GetGroupId(commandId: Integer): Integer;
    function GetGroupIdAt(index: Integer): Integer;
    function SetGroupId(commandId, groupId: Integer): Boolean;
    function SetGroupIdAt(index, groupId: Integer): Boolean;
    function GetSubMenu(commandId: Integer): ICefMenuModel;
    function GetSubMenuAt(index: Integer): ICefMenuModel;
    function IsVisible(commandId: Integer): Boolean;
    function isVisibleAt(index: Integer): Boolean;
    function SetVisible(commandId: Integer; visible: Boolean): Boolean;
    function SetVisibleAt(index: Integer; visible: Boolean): Boolean;
    function IsEnabled(commandId: Integer): Boolean;
    function IsEnabledAt(index: Integer): Boolean;
    function SetEnabled(commandId: Integer; enabled: Boolean): Boolean;
    function SetEnabledAt(index: Integer; enabled: Boolean): Boolean;
    function IsChecked(commandId: Integer): Boolean;
    function IsCheckedAt(index: Integer): Boolean;
    function setChecked(commandId: Integer; checked: Boolean): Boolean;
    function setCheckedAt(index: Integer; checked: Boolean): Boolean;
    function HasAccelerator(commandId: Integer): Boolean;
    function HasAcceleratorAt(index: Integer): Boolean;
    function SetAccelerator(commandId, keyCode: Integer; shiftPressed, ctrlPressed, altPressed: Boolean): Boolean;
    function SetAcceleratorAt(index, keyCode: Integer; shiftPressed, ctrlPressed, altPressed: Boolean): Boolean;
    function RemoveAccelerator(commandId: Integer): Boolean;
    function RemoveAcceleratorAt(index: Integer): Boolean;
    function GetAccelerator(commandId: Integer; out keyCode: Integer; out shiftPressed, ctrlPressed, altPressed: Boolean): Boolean;
    function GetAcceleratorAt(index: Integer; out keyCode: Integer; out shiftPressed, ctrlPressed, altPressed: Boolean): Boolean;
  end;

  ICefNavigationEntry = interface(ICefBase) ['{D8368C8D-F583-4F2B-A56F-7C31AA60F3BB}']
    function IsValid: Boolean;
    function GetUrl: ustring;
    function GetDisplayUrl: ustring;
    function GetOriginalUrl: ustring;
    function GetTitle: ustring;
    function GetTransitionType: TCefTransitionType;
    function HasPostData: Boolean;
    function GetCompletionTime: TDateTime;
    function GetHttpStatusCode: Integer;
  end;

  ICefPrintDialogCallback = interface(ICefBase) ['{85758B5A-2CD1-4704-9491-4E3BD38AC963}']
    procedure Cont(settings: ICefPrintSettings);
    procedure Cancel;
  end;

  ICefPrintJobCallback = interface(ICefBase) ['{A7051D0D-DF53-418D-911C-71D40C172797}']
    procedure Cont;
  end;

  ICefPrintHandler = interface(ICefBase) ['{AE86A8F2-BF28-4DD6-842D-2851FE1408C3}']
    procedure OnPrintStart(const browser: ICefBrowser);
    procedure OnPrintSettings(settings: ICefPrintSettings; getDefaults: Boolean);
    function OnPrintDialog(hasSelection: Boolean; callback: ICefPrintDialogCallback): Boolean;
    function OnPrintJob(const documentName, pdfFilePath: ustring; callback: ICefPrintDialogCallback): Boolean;
    procedure OnPrintReset;
    function GetPdfPaperSize(deviceUnitsPerInch: Integer): TSize;
  end;

  ICefPrintSettings = interface(ICefBase) ['{B9944259-B405-4773-A1F8-86E50B0CAEEF}']
    function IsValid: Boolean;
    function IsReadOnly: Boolean;
    function Copy: ICefPrintSettings;
    procedure SetOrientation(landscape: Boolean);
    function IsLandscape: Boolean;
    procedure SetPrinterPrintableArea(const physicalSizeDeviceUnits: TCefSize;
      const printableAreaDeviceUnits: TCefRect; landscapeNeedsFlip: Boolean);
    procedure SetDeviceName(const name: ustring);
    function GetDeviceName: ustring;
    procedure SetDpi(dpi: Integer);
    function GetDpi: Integer;
    procedure SetPageRanges(rangesCount: TSize; const ranges: TCefPageRangeArray);
    function GetPageRangesCount: TSize;
    procedure GetPageRanges(rangesCount: TSize; out ranges: TCefPageRangeArray);
    procedure SetSelectionOnly(selectionOnly: Boolean);
    function IsSelectionOnly: Boolean;
    procedure SetCollate(collate: Boolean);
    function WillCollate: Boolean;
    procedure SetColorModel(model: TCefColorModel);
    function GetColorModel: TCefColorModel;
    procedure SetCopies(copies: Integer);
    function GetCopies: Integer;
    procedure SetDuplexMode(mode: TCefDuplexMode);
    function GetDuplexMode: TCefDuplexMode;
  end;


  ICefProcessMessage = interface(ICefBase) ['{E0B1001A-8777-425A-869B-29D40B8B93B1}']
    function IsValid: Boolean;
    function IsReadOnly: Boolean;
    function Copy: ICefProcessMessage;
    function GetName: ustring;
    function GetArgumentList: ICefListValue;

    property Name: ustring read GetName;
    property ArgumentList: ICefListValue read GetArgumentList;
  end;

  ICefRenderHandler = interface(ICefBase) ['{2AB9C201-F638-4AFE-ADDA-3DCDB556B2FD}']
    function GetRootScreenRect(const browser: ICefBrowser; rect: PCefRect): Boolean;
    function GetViewRect(const browser: ICefBrowser; rect: PCefRect): Boolean;
    function GetScreenPoint(const browser: ICefBrowser; viewX, viewY: Integer;
      screenX, screenY: PInteger): Boolean;
    function GetScreenInfo(const browser: ICefBrowser; var screenInfo: TCefScreenInfo): Boolean;
    procedure OnPopupShow(const browser: ICefBrowser; show: Boolean);
    procedure OnPopupSize(const browser: ICefBrowser; const rect: PCefRect);
    procedure OnPaint(const browser: ICefBrowser; aType: TCefPaintElementType;
      dirtyRectsCount: TSize; const dirtyRects: PCefRectArray; const buffer: Pointer;
      width, height: Integer);
    procedure OnCursorChange(const browser: ICefBrowser; cursor: TCefCursorHandle; type_: TCefCursorType;
      const customCursorInfo: PCefCursorInfo);
    function StartDragging(const browser: ICefBrowser; const dragData: ICefDragData;
      allowedOps: TCefDragOperationsMask; x, y: Integer): Boolean;
    procedure UpdateDragCursor(const browser: ICefBrowser; operation: TCefDragOperationsMask);
    procedure OnScrollOffsetChanged(const browser: ICefBrowser; x,y: Double);
  end;

  ICefRenderProcessHandler = interface(IcefBase) ['{FADEE3BC-BF66-430A-BA5D-1EE3782ECC58}']
    procedure OnRenderThreadCreated(const ExtraInfo:ICefListValue);
    procedure OnWebKitInitialized;
    procedure OnBrowserCreated(const browser: ICefBrowser);
    procedure OnBrowserDestroyed(const browser: ICefBrowser);
    function GetLoadHandler: ICefLoadHandler;
    function OnBeforeNavigation(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const navigationType: TCefNavigationType;
      const isRedirect: Boolean): Boolean;
    procedure OnContextCreated(const browser: ICefBrowser; const frame: ICefFrame;
      const context: ICefv8Context);
    procedure OnContextReleased(const browser: ICefBrowser; const frame: ICefFrame;
      const context: ICefv8Context);
    procedure OnUncaughtException(const browser: ICefBrowser; const frame: ICefFrame;
      const context: ICefV8Context; const exception: ICefV8Exception; const stackTrace: ICefV8StackTrace);
    procedure OnFocusedNodeChanged(const browser: ICefBrowser; const frame: ICefFrame;
      const node: ICefDomNode);
    function OnProcessMessageReceived(const browser: ICefBrowser; sourceProcess: TCefProcessId;
      const message: ICefProcessMessage): Boolean;
  end;

  ICefRequest = interface(ICefBase) ['{FB4718D3-7D13-4979-9F4C-D7F6C0EC592A}']
    function IsReadOnly: Boolean;
    function GetUrl: ustring;
    procedure SetUrl(const value: ustring);
    function GetMethod: ustring;
    procedure SetMethod(const value: ustring);
    procedure SetReferrer(const referrerUrl: ustring; policy: TCefReferrerPolicy);
    function GetReferrerUrl: ustring;
    function GetReferrerPolicy: TCefReferrerPolicy;
    function GetPostData: ICefPostData;
    procedure SetPostData(const value: ICefPostData);
    procedure GetHeaderMap(const HeaderMap: ICefStringMultimap);
    procedure SetHeaderMap(const HeaderMap: ICefStringMultimap);
    procedure Assign(const url, method: ustring; const postData: ICefPostData; const headerMap: ICefStringMultimap);
    function GetFlags: TCefUrlRequestFlags;
    procedure SetFlags(flags: TCefUrlRequestFlags);
    function GetFirstPartyForCookies: ustring;
    procedure SetFirstPartyForCookies(const url: ustring);
    function GetResourceType: TCefResourceType;
    function GetTransitionType: TCefTransitionType;

    property Url: ustring read GetUrl write SetUrl;
    property Method: ustring read GetMethod write SetMethod;
    property PostData: ICefPostData read GetPostData write SetPostData;
    property Flags: TCefUrlRequestFlags read GetFlags write SetFlags;
    property FirstPartyForCookies: ustring read GetFirstPartyForCookies write SetFirstPartyForCookies;
  end;

  ICefPostData = interface(ICefBase) ['{1E677630-9339-4732-BB99-D6FE4DE4AEC0}']
    function IsReadOnly: Boolean;
    function HasExcludedElements: Boolean;
    function GetElementCount: TSize;
    function GetElements(Count: TSize): IInterfaceList; // ICefPostDataElement
    function RemoveElement(const element: ICefPostDataElement): Integer;
    function AddElement(const element: ICefPostDataElement): Integer;
    procedure RemoveElements;
  end;

  ICefPostDataElement = interface(ICefBase) ['{3353D1B8-0300-4ADC-8D74-4FF31C77D13C}']
    function IsReadOnly: Boolean;
    procedure SetToEmpty;
    procedure SetToFile(const fileName: ustring);
    procedure SetToBytes(size: TSize; const bytes: Pointer);
    function GetType: TCefPostDataElementType;
    function GetFile: ustring;
    function GetBytesCount: TSize;
    function GetBytes(size: TSize; bytes: Pointer): TSize;
  end;

  ICefRequestContext = interface(ICefBase) ['{D8ACE4EB-A23D-407A-92A0-FDACDE97FBC0}']
    function IsSame(other: ICefRequestContext): Boolean;
    function IsSharingWith(other: ICefRequestContext): Boolean;
    function IsGlobal: Boolean;
    function GetHandler: ICefRequestContextHandler;
    function GetCachePath: ustring;
    function GetDefaultCookieManager(callback: ICefCompletionCallback): ICefCookieManager;
    function RegisterSchemeHandlerFactory(const schemeName, domainName: ustring; factory: ICefSchemeHandlerFactory): Boolean;
    function ClearSchemeHandlerFactories: Boolean;
    procedure PurgePluginListCache(reloadPages: Boolean);
    function HasPreference(const name: ustring): Boolean;
    function GetPreference(const name: ustring): ICefValue;
    function GetAllPreferences(includeDefaults: Boolean): ICefDictionaryValue;
    function CanSetPreference(const name: ustring): Boolean;
    function SetPreference(const name: ustring; value: ICefValue; out error: ustring): Boolean;
  end;

  ICefRequestContextHandler = interface(ICefBase) ['{0FC0165C-E871-4C12-8857-A459B5FD8C3F}']
    function GetCookieManager: ICefCookieManager;
    function OnBeforePluginLoad(const mimeType, pluginUrl, topOriginUrl: ustring;
      pluginInfo: ICefWebPluginInfo; pluginPolicy: TCefPluginPolicy): Boolean;
  end;

  ICefRequestCallback = interface(ICefBase) ['{F163D612-CC9C-49CC-ADEA-FB6A32A25485}']
    procedure Cont(allow: Boolean);
    procedure Cancel;
  end;

  ICefRequestHandler = interface(ICefBase) ['{050877A9-D1F8-4EB3-B58E-50DC3E3D39FD}']
    function OnBeforeBrowse(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; isRedirect: Boolean): Boolean;
    function OnOpenUrlFromTab(browser: ICefBrowser; frame: ICefFrame;
      const targetUrl: ustring; targetDisposition: TCefWindowOpenDisposition; useGesture: Boolean): Boolean;
    function OnBeforeResourceLoad(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const callback: ICefRequestCallback): TCefReturnValue;
    function GetResourceHandler(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest): ICefResourceHandler;
    procedure OnResourceRedirect(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; var newUrl: ustring);
    function OnResourceResponse(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const response: ICefResponse): Boolean;
    function GetResourceResponseFilter(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const response: ICefResponse): ICefResponseFilter;
    procedure OnResourceLoadComplete(const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const response: ICefResponse; status: TCefUrlRequestStatus;
      receivedContentLength: Int64);
    function GetAuthCredentials(const browser: ICefBrowser; const frame: ICefFrame;
      isProxy: Boolean; const host: ustring; port: Integer; const realm, scheme: ustring;
      const callback: ICefAuthCallback): Boolean;
    function OnQuotaRequest(const browser: ICefBrowser;
      const originUrl: ustring; newSize: Int64; const callback: ICefRequestCallback): Boolean;
    procedure OnProtocolExecution(const browser: ICefBrowser; const url: ustring;
      out allowOsExecution: Boolean);
    function OnCertificateError(const browser: ICefBrowser; certError: TCefErrorCode;
      const requestUrl: ustring; const sslInfo: ICefSslinfo; callback: ICefRequestCallback): Boolean;
    procedure OnPluginCrashed(const browser: ICefBrowser; const plugin_path: ustring);
    procedure OnRenderViewReady(browser: ICefBrowser);
    procedure OnRenderProcessTerminated(const browser: ICefBrowser; status: TCefTerminationStatus);
  end;

  ICefResourceBundle = interface(ICefBase) ['{47CF1DFA-5186-4DEF-B20C-E3DEA38EF3B6}']
    function GetLokalizedString(stringId: Integer): ustring;
    function GetDataResource(resourceId: Integer; data: PPointer; dataSize: PSize): Boolean;
    function GetDataResourceForScale(resourceId: Integer; scaleFactor: TCefScaleFactor;
      data: PPointer; dataSize: PSize): Boolean;
  end;

  ICefResourceBundleHandler = interface(ICefBase) ['{09C264FD-7E03-41E3-87B3-4234E82B5EA2}']
    function GetLocalizedString(messageId: Integer; out stringVal: ustring): Boolean;
    function GetDataResource(resourceId: Integer; out data: Pointer; out dataSize: TSize): Boolean;
    function GetDataResourceForScale(resourceId: Integer; scaleFactor: TCefScaleFactor;
      out data: Pointer; out dataSize: TSize): Boolean;
  end;

  ICefResourceHandler = interface(ICefBase) ['{BD3EA208-AAAD-488C-BFF2-76993022F2B5}']
    function ProcessRequest(const request: ICefRequest; const callback: ICefCallback): Boolean;
    procedure GetResponseHeaders(const response: ICefResponse;
      out responseLength: Int64; out redirectUrl: ustring);
    function ReadResponse(const dataOut: Pointer; bytesToRead: Integer;
      var bytesRead: Integer; const callback: ICefCallback): Boolean;
    function CanGetCookie(const cookie: PCefCookie): Boolean;
    function CanSetCookie(const cookie: PCefCookie): Boolean;
    procedure Cancel;
  end;

  ICefResponse = interface(ICefBase) ['{E9C896E4-59A8-4B96-AB5E-6EA3A498B7F1}']
    function IsReadOnly: Boolean;
    function GetStatus: Integer;
    procedure SetStatus(status: Integer);
    function GetStatusText: ustring;
    procedure SetStatusText(const StatusText: ustring);
    function GetMimeType: ustring;
    procedure SetMimeType(const mimetype: ustring);
    function GetHeader(const name: ustring): ustring;
    procedure GetHeaderMap(const headerMap: ICefStringMultimap);
    procedure SetHeaderMap(const headerMap: ICefStringMultimap);

    property Status: Integer read GetStatus write SetStatus;
    property StatusText: ustring read GetStatusText write SetStatusText;
    property MimeType: ustring read GetMimeType write SetMimeType;
  end;

  ICefResponseFilter = interface(ICefBase) ['{51A9613C-3D5A-49FD-B9B5-79156D7782AD}']
    function InitFilter: Boolean;
    function Filter(dataIn: Pointer; dataInSize: TSize; out dataInRead: TSize;
      dataOut: Pointer; dataOutSize: TSize; out dataOutWritten: TSize): TCefResponseFilterStatus;
  end;

  ICefSchemeRegistrar = interface(ICefBase) ['{1832FF6E-100B-4E8B-B996-AD633168BEE7}']
    function AddCustomScheme(const schemeName: ustring; isStandard, isLocal,
      isDisplayIsolated: Boolean): Boolean; cconv;
  end;

  ICefSchemeHandlerFactory = interface(ICefBase) ['{4D9B7960-B73B-4EBD-9ABE-6C1C43C245EB}']
    function New(const browser: ICefBrowser; const frame: ICefFrame;
      const schemeName: ustring; const request: ICefRequest): ICefResourceHandler;
  end;

  ICefSslcertPrincipal = interface(ICefBase) ['{6FB4364C-2660-4C4D-945D-6BE492489D8D}']
    function GetDisplayName: ustring;
    function GetCommonName: ustring;
    function GetLocalityName: ustring;
    function GetStateOrProvinceName: ustring;
    function GetCountryName: ustring;
    procedure GetStreetAddresses(addresses: TStrings);
    procedure GetOriganizationNames(names: TStrings);
    procedure GetOriganizationUnitNames(names: TStrings);
    procedure GetDomainComponents(components: TStrings);
  end;

  ICefSslinfo = interface(ICefBase) ['{92F2DC62-4627-4DF9-9738-CDC06B428D47}']
    function GetCertStatus: TCefCertStatus;
    function IsCertStatusError: Boolean;
    function IsCertStatusMinorError: Boolean;
    function GetSubject: ICefSslcertPrincipal;
    function GetIssuer: ICefSslcertPrincipal;
    function GetSerialNumber: ICefBinaryValue;
    function GetValidStart: TDateTime;
    function GetValidExpiry: TDateTime;
    function GetDerencoded: ICefBinaryValue;
    function GetPemencoded: ICefBinaryValue;
    function GetIssuerChainSize: TSize;
    procedure GetDerencodedIssuerChain(out chain: ICefBinaryValueArray);
    procedure GetPemencodedIssuerChain(out chain: ICefBinaryValueArray);
  end;

  ICefReadHandler = interface(ICefBase) ['{F0050618-6C9A-4109-ADF1-A6DD4DC113FC}']
    function Read(ptr: Pointer; size, n: TSize): TSize;
    function Seek(offset: Int64; whence: Integer): Integer;
    function Tell: Int64;
    function Eof: Boolean;
    function MayBlock: Boolean;
  end;

  ICefStreamReader = interface(ICefBase) ['{DD5361CB-E558-49C5-A4BD-D1CE84ADB277}']
    function Read(ptr: Pointer; size, n: TSize): TSize;
    function Seek(offset: Int64; whence: Integer): Integer;
    function Tell: Int64;
    function Eof: Boolean;
    function MayBlock: Boolean;
  end;

  ICefWriteHandler = interface(ICefBase) ['{786A6DE3-B8E0-4551-B46F-DF0253854C3E}']
    function Write(const ptr: Pointer; size, n: TSize): TSize;
    function Seek(offset: Int64; whence: Integer): Integer;
    function Tell: Int64;
    function Flush: Boolean;
    function MayBlock: Boolean;
  end;

  ICefStreamWriter = interface(ICefBase) ['{E952E67B-86F0-4456-ACA0-4C65E816ABB9}']
    function Write(const ptr: Pointer; size, n: TSize): TSize;
    function Seek(offset: Int64; whence: Integer): Integer;
    function Tell: Int64;
    function Flush: Boolean;
    function MayBlock: Boolean;
  end;

  ICefStringVisitor = interface(ICefBase) ['{63ED4D6C-2FC8-4537-964B-B84C008F6158}']
    procedure Visit(const str: ustring);
  end;

  ICefTask = interface(ICefBase) ['{0D965470-4A86-47CE-BD39-A8770021AD7E}']
    procedure Execute;
  end;

  ICefTaskRunner = interface(ICefBase) ['{B933A3B2-75AD-48DA-B820-B573052A7A4A}']
    function IsSame(that: ICefTaskRunner): Boolean;
    function BelongsToCurrentThread: Boolean;
    function BelongsToThread(ThreadID: TCefThreadID): Boolean;
    function PostTask(task: ICefTask): Integer;
    function PostDelayedTask(task: ICefTask; delayMs: Int64): Integer;
  end;

  ICefEndTracingCallback = interface(ICefBase) ['{B6995953-A56A-46AC-B3D1-D644AEC480A5}']
    procedure OnEndTracingComplete(const tracingFile: ustring);
  end;

  ICefUrlRequest = interface(ICefBase) ['{59226AC1-A0FA-4D59-9DF4-A65C42391A67}']
    function GetRequest: ICefRequest;
    function GetClient: ICefUrlRequestClient;
    function GetRequestStatus: TCefUrlRequestStatus;
    function GetRequestError: TCefErrorcode;
    function GetResponse: ICefResponse;
    procedure Cancel;
  end;

  ICefUrlRequestClient = interface(ICefBase) ['{114155BD-C248-4651-9A4F-26F3F9A4F737}']
    procedure OnRequestComplete(const request: ICefUrlRequest);
    procedure OnUploadProgress(const request: ICefUrlRequest; current, total: Int64);
    procedure OnDownloadProgress(const request: ICefUrlRequest; current, total: Int64);
    procedure OnDownloadData(const request: ICefUrlRequest; data: Pointer; dataLength: TSize);
    function GetAuthCredentials(isProxy: Boolean; const host: ustring; port: Integer;
      const realm, scheme: ustring; callback: ICefAuthCallback): Boolean;
  end;

  ICefv8Context = interface(ICefBase) ['{2295A11A-8773-41F2-AD42-308C215062D9}']
    function GetTaskRunner: ICefTaskRunner;
    function IsValid: Boolean;
    function GetBrowser: ICefBrowser;
    function GetFrame: ICefFrame;
    function GetGlobal: ICefv8Value;
    function Enter: Boolean;
    function Exit: Boolean;
    function IsSame(const that: ICefv8Context): Boolean;
    function Eval(const code: ustring; var retval: ICefv8Value; var exception: ICefV8Exception): Boolean;

    property Browser: ICefBrowser read GetBrowser;
    property Frame: ICefFrame read GetFrame;
    property Global: ICefv8Value read GetGlobal;
  end;

  ICefv8Handler = interface(ICefBase) ['{F94CDC60-FDCB-422D-96D5-D2A775BD5D73}']
    function Execute(const name: ustring; const obj: ICefv8Value;
      const arguments: ICefv8ValueArray; var retval: ICefv8Value;
      var exception: ustring): Boolean;
  end;

  ICefV8Accessor = interface(ICefBase) ['{DCA6D4A2-726A-4E24-AA64-5E8C731D868A}']
    function Get(const name: ustring; const obj: ICefv8Value;
      out value: ICefv8Value; const exception: ustring): Boolean;
    function Put(const name: ustring; const obj: ICefv8Value;
      const value: ICefv8Value; const exception: ustring): Boolean;
  end;

  ICefV8Exception = interface(ICefBase) ['{7E422CF0-05AC-4A60-A029-F45105DCE6A4}']
    function GetMessage: ustring;
    function GetSourceLine: ustring;
    function GetScriptResourceName: ustring;
    function GetLineNumber: Integer;
    function GetStartPosition: Integer;
    function GetEndPosition: Integer;
    function GetStartColumn: Integer;
    function GetEndColumn: Integer;

    property Message: ustring read GetMessage;
    property SourceLine: ustring read GetSourceLine;
    property ScriptResourceName: ustring read GetScriptResourceName;
    property LineNumber: Integer read GetLineNumber;
    property StartPosition: Integer read GetStartPosition;
    property EndPosition: Integer read GetEndPosition;
    property StartColumn: Integer read GetStartColumn;
    property EndColumn: Integer read GetEndColumn;
  end;

  ICefv8Value = interface(ICefBase) ['{52319B8D-75A8-422C-BD4B-16FA08CC7F42}']
    function IsValid: Boolean;
    function IsUndefined: Boolean;
    function IsNull: Boolean;
    function IsBool: Boolean;
    function IsInt: Boolean;
    function IsUInt: Boolean;
    function IsDouble: Boolean;
    function IsDate: Boolean;
    function IsString: Boolean;
    function IsObject: Boolean;
    function IsArray: Boolean;
    function IsFunction: Boolean;
    function IsSame(const that: ICefv8Value): Boolean;
    function GetBoolValue: Boolean;
    function GetIntValue: Integer;
    function GetUIntValue: Cardinal;
    function GetDoubleValue: Double;
    function GetDateValue: TDateTime;
    function GetStringValue: ustring;
    function IsUserCreated: Boolean;
    function HasException: Boolean;
    function GetException: ICefV8Exception;
    function ClearException: Boolean;
    function WillRethrowExceptions: Boolean;
    function SetRethrowExceptions(rethrow: Boolean): Boolean;
    function HasValueByKey(const key: ustring): Boolean;
    function HasValueByIndex(index: Integer): Boolean;
    function DeleteValueByKey(const key: ustring): Boolean;
    function DeleteValueByIndex(index: Integer): Boolean;
    function GetValueByKey(const key: ustring): ICefv8Value;
    function GetValueByIndex(index: Integer): ICefv8Value;
    function SetValueByKey(const key: ustring; const value: ICefv8Value;
      attribute: TCefV8PropertyAttributes): Boolean;
    function SetValueByIndex(index: Integer; const value: ICefv8Value): Boolean;
    function SetValueByAccessor(const key: ustring; settings: TCefV8AccessControls;
      attribute: TCefV8PropertyAttributes): Boolean;
    function GetKeys(const keys: TStrings): Integer;
    function SetUserData(const data: ICefv8Value): Boolean;
    function GetUserData: ICefv8Value;
    function GetExternallyAllocatedMemory: Integer;
    function AdjustExternallyAllocatedMemory(changeInBytes: Integer): Integer;
    function GetArrayLength: Integer;
    function GetFunctionName: ustring;
    function GetFunctionHandler: ICefv8Handler;
    function ExecuteFunction(const obj: ICefv8Value;
      const arguments: ICefv8ValueArray): ICefv8Value;
    function ExecuteFunctionWithContext(const context: ICefv8Context;
      const obj: ICefv8Value; const arguments: ICefv8ValueArray): ICefv8Value;
  end;

  ICefV8StackTrace = interface(ICefBase) ['{32111C84-B7F7-4E3A-92B9-7CA1D0ADB613}']
    function IsValid: Boolean;
    function GetFrameCount: Integer;
    function GetFrame(index: Integer): ICefV8StackFrame;
    property FrameCount: Integer read GetFrameCount;
    property Frame[index: Integer]: ICefV8StackFrame read GetFrame;
  end;

  ICefV8StackFrame = interface(ICefBase) ['{BA1FFBF4-E9F2-4842-A827-DC220F324286}']
    function IsValid: Boolean;
    function GetScriptName: ustring;
    function GetScriptNameOrSourceUrl: ustring;
    function GetFunctionName: ustring;
    function GetLineNumber: Integer;
    function GetColumn: Integer;
    function IsEval: Boolean;
    function IsConstructor: Boolean;

    property ScriptName: ustring read GetScriptName;
    property ScriptNameOrSourceUrl: ustring read GetScriptNameOrSourceUrl;
    property FunctionName: ustring read GetFunctionName;
    property LineNumber: Integer read GetLineNumber;
    property Column: Integer read GetColumn;
  end;

  ICefValue = interface(ICefBase) ['{449E2248-4415-4CEF-BC70-6C3FE13D36B6}']
    function IsValid: Boolean;
    function IsOwned: Boolean;
    function IsReadOnly: Boolean;
    function IsSame(that: ICefValue): Boolean;
    function IsEqual(that: ICefValue): Boolean;
    function Copy: ICefValue;
    function GetType: TCefValueType;
    function GetBool: Boolean;
    function GetInt: Integer;
    function GetDouble: Double;
    function GetString: ustring;
    function GetBinary: ICefBinaryValue;
    function GetDictionary: ICefDictionaryValue;
    function GetList: ICefListValue;
    function SetNull: Boolean;
    function SetBool(value: Boolean): Boolean;
    function SetInt(value: Integer): Boolean;
    function SetDouble(value: Double): Boolean;
    function SetString(value: ustring): Boolean;
    function SetBinary(value: ICefBinaryValue): Boolean;
    function SetDictionary(value: ICefDictionaryValue): Boolean;
    function SetList(value: ICefListValue): Boolean;
  end;

  ICefBinaryValue = interface(ICefBase) ['{974AA40A-9C5C-4726-81F0-9F0D46D7C5B3}']
    function IsValid: Boolean;
    function IsOwned: Boolean;
    function IsSame(that: ICefBinaryValue): Boolean;
    function IsEqual(that: ICefBinaryValue): Boolean;
    function Copy: ICefBinaryValue;
    function GetSize: TSize;
    function GetData(buffer: Pointer; bufferSize, dataOffset: TSize): TSize;
  end;

  ICefDictionaryValue = interface(ICefBase) ['{B9638559-54DC-498C-8185-233EEF12BC69}']
    function IsValid: Boolean;
    function IsOwned: Boolean;
    function IsReadOnly: Boolean;
    function IsSame(that: ICefDictionaryValue): Boolean;
    function IsEqual(that: ICefDictionaryValue): Boolean;
    function Copy(excludeEmptyChildren: Boolean): ICefDictionaryValue;
    function GetSize: TSize;
    function Clear: Boolean;
    function HasKey(const key: ustring): Boolean;
    function GetKeys(const keys: TStrings): Boolean;
    function Remove(const key: ustring): Boolean;
    function GetType(const key: ustring): TCefValueType;
    function GetValue(const key: ustring): ICefValue;
    function GetBool(const key: ustring): Boolean;
    function GetInt(const key: ustring): Integer;
    function GetDouble(const key: ustring): Double;
    function GetString(const key: ustring): ustring;
    function GetBinary(const key: ustring): ICefBinaryValue;
    function GetDictionary(const key: ustring): ICefDictionaryValue;
    function GetList(const key: ustring): ICefListValue;
    function SetValue(const key: ustring; value: ICefValue): Boolean;
    function SetNull(const key: ustring): Boolean;
    function SetBool(const key: ustring; value: Boolean): Boolean;
    function SetInt(const key: ustring; value: Integer): Boolean;
    function SetDouble(const key: ustring; value: Double): Boolean;
    function SetString(const key, value: ustring): Boolean;
    function SetBinary(const key: ustring; const value: ICefBinaryValue): Boolean;
    function SetDictionary(const key: ustring; const value: ICefDictionaryValue): Boolean;
    function SetList(const key: ustring; const value: ICefListValue): Boolean;
  end;

  ICefListValue = interface(ICefBase) ['{09174B9D-0CC6-4360-BBB0-3CC0117F70F6}']
    function IsValid: Boolean;
    function IsOwned: Boolean;
    function IsReadOnly: Boolean;
    function IsSame(that: ICefListValue): Boolean;
    function IsEqual(that: ICefListValue): Boolean;
    function Copy: ICefListValue;
    function SetSize(size: TSize): Boolean;
    function GetSize: TSize;
    function Clear: Boolean;
    function Remove(index: Integer): Boolean;
    function GetType(index: Integer): TCefValueType;
    function GetValue(index: Integer): ICefValue;
    function GetBool(index: Integer): Boolean;
    function GetInt(index: Integer): Integer;
    function GetDouble(index: Integer): Double;
    function GetString(index: Integer): ustring;
    function GetBinary(index: Integer): ICefBinaryValue;
    function GetDictionary(index: Integer): ICefDictionaryValue;
    function GetList(index: Integer): ICefListValue;
    function SetValue(index: Integer; value: ICefValue): Boolean;
    function SetNull(index: Integer): Boolean;
    function SetBool(index: Integer; value: Boolean): Boolean;
    function SetInt(index, value: Integer): Boolean;
    function SetDouble(index: Integer; value: Double): Boolean;
    function SetString(index: Integer; const value: ustring): Boolean;
    function SetBinary(index: Integer; const value: ICefBinaryValue): Boolean;
    function SetDictionary(index: Integer; const value: ICefDictionaryValue): Boolean;
    function SetList(index: Integer; const value: ICefListValue): Boolean;
  end;

  ICefWebPluginInfo = interface(ICefBase) ['{AA879E58-F649-44B1-AF9C-655FF5B79A02}']
    function GetName: ustring;
    function GetPath: ustring;
    function GetVersion: ustring;
    function GetDescription: ustring;

    property Name: ustring read GetName;
    property Path: ustring read GetPath;
    property Version: ustring read GetVersion;
    property Description: ustring read GetDescription;
  end;

  ICefWebPluginInfoVisitor = interface(ICefBase) ['{7523D432-4424-4804-ACAD-E67D2313436E}']
    function Visit(const info: ICefWebPluginInfo; count, total: Integer): Boolean;
  end;

  ICefWebPluginUnstableCallback = interface(ICefBase) ['{67459829-EB47-4B7E-9D69-2EE77DF0E71E}']
    procedure IsUnstable(const path: ustring; unstable: Boolean);
  end;

  ICefXmlReader = interface(ICefBase) ['{0DE686C3-A8D7-45D2-82FD-92F7F4E62A90}']
    function MoveToNextNode: Boolean;
    function Close: Boolean;
    function HasError: Boolean;
    function GetError: ustring;
    function GetType: TCefXmlNodeType;
    function GetDepth: Integer;
    function GetLocalName: ustring;
    function GetPrefix: ustring;
    function GetQualifiedName: ustring;
    function GetNamespaceUri: ustring;
    function GetBaseUri: ustring;
    function GetXmlLang: ustring;
    function IsEmptyElement: Boolean;
    function HasValue: Boolean;
    function GetValue: ustring;
    function HasAttributes: Boolean;
    function GetAttributeCount: TSize;
    function GetAttributeByIndex(index: Integer): ustring;
    function GetAttributeByQName(const qualifiedName: ustring): ustring;
    function GetAttributeByLName(const localName, namespaceURI: ustring): ustring;
    function GetInnerXml: ustring;
    function GetOuterXml: ustring;
    function GetLineNumber: Integer;
    function MoveToAttributeByIndex(index: Integer): Boolean;
    function MoveToAttributeByQName(const qualifiedName: ustring): Boolean;
    function MoveToAttributeByLName(const localName, namespaceURI: ustring): Boolean;
    function MoveToFirstAttribute: Boolean;
    function MoveToNextAttribute: Boolean;
    function MoveToCarryingElement: Boolean;
  end;

  ICefZipReader = interface(ICefBase) ['{3B6C591F-9877-42B3-8892-AA7B27DA34A8}']
    function MoveToFirstFile: Boolean;
    function MoveToNextFile: Boolean;
    function MoveToFile(const fileName: ustring; caseSensitive: Boolean): Boolean;
    function Close: Boolean;
    function GetFileName: ustring;
    function GetFileSize: Int64;
    function GetFileLastModified: TCefTime;
    function OpenFile(const password: ustring): Boolean;
    function CloseFile: Boolean;
    function ReadFile(buffer: Pointer; bufferSize: TSize): Integer;
    function Tell: Int64;
    function Eof: Boolean;
  end;

  ICefStringMap = interface ['{A33EBC01-B23A-4918-86A4-E24A243B342F}']
    function GetHandle: TCefStringMap;
    function GetSize: Integer;
    function Find(const Key: ustring): ustring;
    function GetKey(Index: Integer): ustring;
    function GetValue(Index: Integer): ustring;
    procedure Append(const Key, Value: ustring);
    procedure Clear;

    property Handle: TCefStringMap read GetHandle;
    property Size: Integer read GetSize;
    property Key[index: Integer]: ustring read GetKey;
    property Value[index: Integer]: ustring read GetValue;
  end;

  ICefStringMultimap = interface ['{583ED0C2-A9D6-4034-A7C9-20EC7E47F0C7}']
    function GetHandle: TCefStringMultimap;
    function GetSize: Integer;
    function FindCount(const Key: ustring): Integer;
    function GetEnumerate(const Key: ustring; ValueIndex: Integer): ustring;
    function GetKey(Index: Integer): ustring;
    function GetValue(Index: Integer): ustring;
    procedure Append(const Key, Value: ustring);
    procedure Clear;

    property Handle: TCefStringMap read GetHandle;
    property Size: Integer read GetSize;
    property Key[index: Integer]: ustring read GetKey;
    property Value[index: Integer]: ustring read GetValue;
    property Enumerate[const aKey: ustring; ValueIndex: Integer]: ustring read GetEnumerate;
  end;

Implementation

end.
