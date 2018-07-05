package artsoftconsult.study.utils;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Component
public class Email {
    private static final String emailTemplate = "<!doctype html>\n" +
            "<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n" +
            "<head>\n" +
            "<!-- NAME: 1 COLUMN -->\n" +
            "<!--[if gte mso 15]>\n" +
            "<xml>\n" +
            "<o:OfficeDocumentSettings>\n" +
            "<o:AllowPNG/>\n" +
            "<o:PixelsPerInch>96</o:PixelsPerInch>\n" +
            "</o:OfficeDocumentSettings>\n" +
            "</xml>\n" +
            "<![endif]-->\n" +
            "<meta charset=\"UTF-8\">\n" +
            "        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
            "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n" +
            "<title>{emailSubject}</title>\n" +
            "        \n" +
            "    <style type=\"text/css\">\n" +
            "p{\n" +
            "margin:10px 0;\n" +
            "padding:0;\n" +
            "}\n" +
            "table{\n" +
            "border-collapse:collapse;\n" +
            "}\n" +
            "h1,h2,h3,h4,h5,h6{\n" +
            "display:block;\n" +
            "margin:0;\n" +
            "padding:0;\n" +
            "}\n" +
            "img,a img{\n" +
            "border:0;\n" +
            "height:auto;\n" +
            "outline:none;\n" +
            "text-decoration:none;\n" +
            "}\n" +
            "body,#bodyTable,#bodyCell{\n" +
            "height:100%;\n" +
            "margin:0;\n" +
            "padding:0;\n" +
            "width:100%;\n" +
            "}\n" +
            ".mcnPreviewText{\n" +
            "display:none !important;\n" +
            "}\n" +
            "#outlook a{\n" +
            "padding:0;\n" +
            "}\n" +
            "img{\n" +
            "-ms-interpolation-mode:bicubic;\n" +
            "}\n" +
            "table{\n" +
            "mso-table-lspace:0pt;\n" +
            "mso-table-rspace:0pt;\n" +
            "}\n" +
            ".ReadMsgBody{\n" +
            "width:100%;\n" +
            "}\n" +
            ".ExternalClass{\n" +
            "width:100%;\n" +
            "}\n" +
            "p,a,li,td,blockquote{\n" +
            "mso-line-height-rule:exactly;\n" +
            "}\n" +
            "a[href^=tel],a[href^=sms]{\n" +
            "color:inherit;\n" +
            "cursor:default;\n" +
            "text-decoration:none;\n" +
            "}\n" +
            "p,a,li,td,body,table,blockquote{\n" +
            "-ms-text-size-adjust:100%;\n" +
            "-webkit-text-size-adjust:100%;\n" +
            "}\n" +
            ".ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{\n" +
            "line-height:100%;\n" +
            "}\n" +
            "a[x-apple-data-detectors]{\n" +
            "color:inherit !important;\n" +
            "text-decoration:none !important;\n" +
            "font-size:inherit !important;\n" +
            "font-family:inherit !important;\n" +
            "font-weight:inherit !important;\n" +
            "line-height:inherit !important;\n" +
            "}\n" +
            "#bodyCell{\n" +
            "padding:10px;\n" +
            "}\n" +
            ".templateContainer{\n" +
            "max-width:600px !important;\n" +
            "}\n" +
            "a.mcnButton{\n" +
            "display:block;\n" +
            "}\n" +
            ".mcnImage,.mcnRetinaImage{\n" +
            "vertical-align:bottom;\n" +
            "}\n" +
            ".mcnTextContent{\n" +
            "word-break:break-word;\n" +
            "}\n" +
            ".mcnTextContent img{\n" +
            "height:auto !important;\n" +
            "}\n" +
            ".mcnDividerBlock{\n" +
            "table-layout:fixed !important;\n" +
            "}\n" +
            "/*\n" +
            "@tab Page\n" +
            "@section Background Style\n" +
            "@tip Set the background color and top border for your email. You may want to choose colors that match your company's branding.\n" +
            "*/\n" +
            "body,#bodyTable{\n" +
            "/*@editable*/background-color:#ffffff;\n" +
            "}\n" +
            "/*\n" +
            "@tab Page\n" +
            "@section Background Style\n" +
            "@tip Set the background color and top border for your email. You may want to choose colors that match your company's branding.\n" +
            "*/\n" +
            "#bodyCell{\n" +
            "/*@editable*/border-top:0;\n" +
            "}\n" +
            "/*\n" +
            "@tab Page\n" +
            "@section Email Border\n" +
            "@tip Set the border for your email.\n" +
            "*/\n" +
            ".templateContainer{\n" +
            "/*@editable*/border:0;\n" +
            "}\n" +
            "/*\n" +
            "@tab Page\n" +
            "@section Heading 1\n" +
            "@tip Set the styling for all first-level headings in your emails. These should be the largest of your headings.\n" +
            "@style heading 1\n" +
            "*/\n" +
            "h1{\n" +
            "/*@editable*/color:#202020;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:26px;\n" +
            "/*@editable*/font-style:normal;\n" +
            "/*@editable*/font-weight:bold;\n" +
            "/*@editable*/line-height:125%;\n" +
            "/*@editable*/letter-spacing:normal;\n" +
            "/*@editable*/text-align:left;\n" +
            "}\n" +
            "/*\n" +
            "@tab Page\n" +
            "@section Heading 2\n" +
            "@tip Set the styling for all second-level headings in your emails.\n" +
            "@style heading 2\n" +
            "*/\n" +
            "h2{\n" +
            "/*@editable*/color:#202020;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:22px;\n" +
            "/*@editable*/font-style:normal;\n" +
            "/*@editable*/font-weight:bold;\n" +
            "/*@editable*/line-height:125%;\n" +
            "/*@editable*/letter-spacing:normal;\n" +
            "/*@editable*/text-align:left;\n" +
            "}\n" +
            "/*\n" +
            "@tab Page\n" +
            "@section Heading 3\n" +
            "@tip Set the styling for all third-level headings in your emails.\n" +
            "@style heading 3\n" +
            "*/\n" +
            "h3{\n" +
            "/*@editable*/color:#202020;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:20px;\n" +
            "/*@editable*/font-style:normal;\n" +
            "/*@editable*/font-weight:bold;\n" +
            "/*@editable*/line-height:125%;\n" +
            "/*@editable*/letter-spacing:normal;\n" +
            "/*@editable*/text-align:left;\n" +
            "}\n" +
            "/*\n" +
            "@tab Page\n" +
            "@section Heading 4\n" +
            "@tip Set the styling for all fourth-level headings in your emails. These should be the smallest of your headings.\n" +
            "@style heading 4\n" +
            "*/\n" +
            "h4{\n" +
            "/*@editable*/color:#202020;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:18px;\n" +
            "/*@editable*/font-style:normal;\n" +
            "/*@editable*/font-weight:bold;\n" +
            "/*@editable*/line-height:125%;\n" +
            "/*@editable*/letter-spacing:normal;\n" +
            "/*@editable*/text-align:left;\n" +
            "}\n" +
            "/*\n" +
            "@tab Preheader\n" +
            "@section Preheader Style\n" +
            "@tip Set the background color and borders for your email's preheader area.\n" +
            "*/\n" +
            "#templatePreheader{\n" +
            "/*@editable*/background-color:#fafafa;\n" +
            "/*@editable*/background-image:none;\n" +
            "/*@editable*/background-repeat:no-repeat;\n" +
            "/*@editable*/background-position:center;\n" +
            "/*@editable*/background-size:cover;\n" +
            "/*@editable*/border-top:0;\n" +
            "/*@editable*/border-bottom:0;\n" +
            "/*@editable*/padding-top:9px;\n" +
            "/*@editable*/padding-bottom:9px;\n" +
            "}\n" +
            "/*\n" +
            "@tab Preheader\n" +
            "@section Preheader Text\n" +
            "@tip Set the styling for your email's preheader text. Choose a size and color that is easy to read.\n" +
            "*/\n" +
            "#templatePreheader .mcnTextContent,#templatePreheader .mcnTextContent p{\n" +
            "/*@editable*/color:#656565;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:12px;\n" +
            "/*@editable*/line-height:150%;\n" +
            "/*@editable*/text-align:left;\n" +
            "}\n" +
            "/*\n" +
            "@tab Preheader\n" +
            "@section Preheader Link\n" +
            "@tip Set the styling for your email's preheader links. Choose a color that helps them stand out from your text.\n" +
            "*/\n" +
            "#templatePreheader .mcnTextContent a,#templatePreheader .mcnTextContent p a{\n" +
            "/*@editable*/color:#656565;\n" +
            "/*@editable*/font-weight:normal;\n" +
            "/*@editable*/text-decoration:underline;\n" +
            "}\n" +
            "/*\n" +
            "@tab Header\n" +
            "@section Header Style\n" +
            "@tip Set the background color and borders for your email's header area.\n" +
            "*/\n" +
            "#templateHeader{\n" +
            "/*@editable*/background-color:#FFFFFF;\n" +
            "/*@editable*/background-image:none;\n" +
            "/*@editable*/background-repeat:no-repeat;\n" +
            "/*@editable*/background-position:center;\n" +
            "/*@editable*/background-size:cover;\n" +
            "/*@editable*/border-top:0;\n" +
            "/*@editable*/border-bottom:0;\n" +
            "/*@editable*/padding-top:9px;\n" +
            "/*@editable*/padding-bottom:0;\n" +
            "}\n" +
            "/*\n" +
            "@tab Header\n" +
            "@section Header Text\n" +
            "@tip Set the styling for your email's header text. Choose a size and color that is easy to read.\n" +
            "*/\n" +
            "#templateHeader .mcnTextContent,#templateHeader .mcnTextContent p{\n" +
            "/*@editable*/color:#202020;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:16px;\n" +
            "/*@editable*/line-height:150%;\n" +
            "/*@editable*/text-align:left;\n" +
            "}\n" +
            "/*\n" +
            "@tab Header\n" +
            "@section Header Link\n" +
            "@tip Set the styling for your email's header links. Choose a color that helps them stand out from your text.\n" +
            "*/\n" +
            "#templateHeader .mcnTextContent a,#templateHeader .mcnTextContent p a{\n" +
            "/*@editable*/color:#2BAADF;\n" +
            "/*@editable*/font-weight:normal;\n" +
            "/*@editable*/text-decoration:underline;\n" +
            "}\n" +
            "/*\n" +
            "@tab Body\n" +
            "@section Body Style\n" +
            "@tip Set the background color and borders for your email's body area.\n" +
            "*/\n" +
            "#templateBody{\n" +
            "/*@editable*/background-color:#FFFFFF;\n" +
            "/*@editable*/background-image:none;\n" +
            "/*@editable*/background-repeat:no-repeat;\n" +
            "/*@editable*/background-position:center;\n" +
            "/*@editable*/background-size:cover;\n" +
            "/*@editable*/border-top:0;\n" +
            "/*@editable*/border-bottom:2px solid #EAEAEA;\n" +
            "/*@editable*/padding-top:0;\n" +
            "/*@editable*/padding-bottom:9px;\n" +
            "}\n" +
            "/*\n" +
            "@tab Body\n" +
            "@section Body Text\n" +
            "@tip Set the styling for your email's body text. Choose a size and color that is easy to read.\n" +
            "*/\n" +
            "#templateBody .mcnTextContent,#templateBody .mcnTextContent p{\n" +
            "/*@editable*/color:#202020;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:16px;\n" +
            "/*@editable*/line-height:150%;\n" +
            "/*@editable*/text-align:left;\n" +
            "}\n" +
            "/*\n" +
            "@tab Body\n" +
            "@section Body Link\n" +
            "@tip Set the styling for your email's body links. Choose a color that helps them stand out from your text.\n" +
            "*/\n" +
            "#templateBody .mcnTextContent a,#templateBody .mcnTextContent p a{\n" +
            "/*@editable*/color:#2BAADF;\n" +
            "/*@editable*/font-weight:normal;\n" +
            "/*@editable*/text-decoration:underline;\n" +
            "}\n" +
            "/*\n" +
            "@tab Footer\n" +
            "@section Footer Style\n" +
            "@tip Set the background color and borders for your email's footer area.\n" +
            "*/\n" +
            "#templateFooter{\n" +
            "/*@editable*/background-color:#FAFAFA;\n" +
            "/*@editable*/background-image:none;\n" +
            "/*@editable*/background-repeat:no-repeat;\n" +
            "/*@editable*/background-position:center;\n" +
            "/*@editable*/background-size:cover;\n" +
            "/*@editable*/border-top:0;\n" +
            "/*@editable*/border-bottom:0;\n" +
            "/*@editable*/padding-top:9px;\n" +
            "/*@editable*/padding-bottom:9px;\n" +
            "}\n" +
            "/*\n" +
            "@tab Footer\n" +
            "@section Footer Text\n" +
            "@tip Set the styling for your email's footer text. Choose a size and color that is easy to read.\n" +
            "*/\n" +
            "#templateFooter .mcnTextContent,#templateFooter .mcnTextContent p{\n" +
            "/*@editable*/color:#656565;\n" +
            "/*@editable*/font-family:Helvetica;\n" +
            "/*@editable*/font-size:12px;\n" +
            "/*@editable*/line-height:150%;\n" +
            "/*@editable*/text-align:center;\n" +
            "}\n" +
            "/*\n" +
            "@tab Footer\n" +
            "@section Footer Link\n" +
            "@tip Set the styling for your email's footer links. Choose a color that helps them stand out from your text.\n" +
            "*/\n" +
            "#templateFooter .mcnTextContent a,#templateFooter .mcnTextContent p a{\n" +
            "/*@editable*/color:#656565;\n" +
            "/*@editable*/font-weight:normal;\n" +
            "/*@editable*/text-decoration:underline;\n" +
            "}\n" +
            "@media only screen and (min-width:768px){\n" +
            ".templateContainer{\n" +
            "width:600px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "body,table,td,p,a,li,blockquote{\n" +
            "-webkit-text-size-adjust:none !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "body{\n" +
            "width:100% !important;\n" +
            "min-width:100% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "#bodyCell{\n" +
            "padding-top:10px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnRetinaImage{\n" +
            "max-width:100% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnImage{\n" +
            "width:100% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnCartContainer,.mcnCaptionTopContent,.mcnRecContentContainer,.mcnCaptionBottomContent,.mcnTextContentContainer,.mcnBoxedTextContentContainer,.mcnImageGroupContentContainer,.mcnCaptionLeftTextContentContainer,.mcnCaptionRightTextContentContainer,.mcnCaptionLeftImageContentContainer,.mcnCaptionRightImageContentContainer,.mcnImageCardLeftTextContentContainer,.mcnImageCardRightTextContentContainer,.mcnImageCardLeftImageContentContainer,.mcnImageCardRightImageContentContainer{\n" +
            "max-width:100% !important;\n" +
            "width:100% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnBoxedTextContentContainer{\n" +
            "min-width:100% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnImageGroupContent{\n" +
            "padding:9px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnCaptionLeftContentOuter .mcnTextContent,.mcnCaptionRightContentOuter .mcnTextContent{\n" +
            "padding-top:9px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnImageCardTopImageContent,.mcnCaptionBottomContent:last-child .mcnCaptionBottomImageContent,.mcnCaptionBlockInner .mcnCaptionTopContent:last-child .mcnTextContent{\n" +
            "padding-top:18px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnImageCardBottomImageContent{\n" +
            "padding-bottom:9px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnImageGroupBlockInner{\n" +
            "padding-top:0 !important;\n" +
            "padding-bottom:0 !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnImageGroupBlockOuter{\n" +
            "padding-top:9px !important;\n" +
            "padding-bottom:9px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnTextContent,.mcnBoxedTextContentColumn{\n" +
            "padding-right:18px !important;\n" +
            "padding-left:18px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcnImageCardLeftImageContent,.mcnImageCardRightImageContent{\n" +
            "padding-right:18px !important;\n" +
            "padding-bottom:0 !important;\n" +
            "padding-left:18px !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            ".mcpreview-image-uploader{\n" +
            "display:none !important;\n" +
            "width:100% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Heading 1\n" +
            "@tip Make the first-level headings larger in size for better readability on small screens.\n" +
            "*/\n" +
            "h1{\n" +
            "/*@editable*/font-size:22px !important;\n" +
            "/*@editable*/line-height:125% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Heading 2\n" +
            "@tip Make the second-level headings larger in size for better readability on small screens.\n" +
            "*/\n" +
            "h2{\n" +
            "/*@editable*/font-size:20px !important;\n" +
            "/*@editable*/line-height:125% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Heading 3\n" +
            "@tip Make the third-level headings larger in size for better readability on small screens.\n" +
            "*/\n" +
            "h3{\n" +
            "/*@editable*/font-size:18px !important;\n" +
            "/*@editable*/line-height:125% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Heading 4\n" +
            "@tip Make the fourth-level headings larger in size for better readability on small screens.\n" +
            "*/\n" +
            "h4{\n" +
            "/*@editable*/font-size:16px !important;\n" +
            "/*@editable*/line-height:150% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Boxed Text\n" +
            "@tip Make the boxed text larger in size for better readability on small screens. We recommend a font size of at least 16px.\n" +
            "*/\n" +
            ".mcnBoxedTextContentContainer .mcnTextContent,.mcnBoxedTextContentContainer .mcnTextContent p{\n" +
            "/*@editable*/font-size:14px !important;\n" +
            "/*@editable*/line-height:150% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Preheader Visibility\n" +
            "@tip Set the visibility of the email's preheader on small screens. You can hide it to save space.\n" +
            "*/\n" +
            "#templatePreheader{\n" +
            "/*@editable*/display:block !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Preheader Text\n" +
            "@tip Make the preheader text larger in size for better readability on small screens.\n" +
            "*/\n" +
            "#templatePreheader .mcnTextContent,#templatePreheader .mcnTextContent p{\n" +
            "/*@editable*/font-size:14px !important;\n" +
            "/*@editable*/line-height:150% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Header Text\n" +
            "@tip Make the header text larger in size for better readability on small screens.\n" +
            "*/\n" +
            "#templateHeader .mcnTextContent,#templateHeader .mcnTextContent p{\n" +
            "/*@editable*/font-size:16px !important;\n" +
            "/*@editable*/line-height:150% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Body Text\n" +
            "@tip Make the body text larger in size for better readability on small screens. We recommend a font size of at least 16px.\n" +
            "*/\n" +
            "#templateBody .mcnTextContent,#templateBody .mcnTextContent p{\n" +
            "/*@editable*/font-size:16px !important;\n" +
            "/*@editable*/line-height:150% !important;\n" +
            "}\n" +
            "\n" +
            "}@media only screen and (max-width: 480px){\n" +
            "/*\n" +
            "@tab Mobile Styles\n" +
            "@section Footer Text\n" +
            "@tip Make the footer content text larger in size for better readability on small screens.\n" +
            "*/\n" +
            "#templateFooter .mcnTextContent,#templateFooter .mcnTextContent p{\n" +
            "/*@editable*/font-size:14px !important;\n" +
            "/*@editable*/line-height:150% !important;\n" +
            "}\n" +
            "\n" +
            "}</style></head>\n" +
            "    <body>\n" +
            "<!--*|IF:MC_PREVIEW_TEXT|*-->\n" +
            "<!--[if !gte mso 9]><!----><span class=\"mcnPreviewText\" style=\"display:none; font-size:0px; line-height:0px; max-height:0px; max-width:0px; opacity:0; overflow:hidden; visibility:hidden; mso-hide:all;\">{emailPreviewText}</span><!--<![endif]-->\n" +
            "<!--*|END:IF|*-->\n" +
            "        <center>\n" +
            "            <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" height=\"100%\" width=\"100%\" id=\"bodyTable\">\n" +
            "                <tr>\n" +
            "                    <td align=\"center\" valign=\"top\" id=\"bodyCell\">\n" +
            "                        <!-- BEGIN TEMPLATE // -->\n" +
            "<!--[if (gte mso 9)|(IE)]>\n" +
            "<table align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"600\" style=\"width:600px;\">\n" +
            "<tr>\n" +
            "<td align=\"center\" valign=\"top\" width=\"600\" style=\"width:600px;\">\n" +
            "<![endif]-->\n" +
            "                        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"templateContainer\">\n" +
            "                            <tr>\n" +
            "                                <td valign=\"top\" id=\"templatePreheader\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"mcnImageBlock\" style=\"min-width:100%;\">\n" +
            "    <tbody class=\"mcnImageBlockOuter\">\n" +
            "            <tr>\n" +
            "                <td valign=\"top\" style=\"padding:9px\" class=\"mcnImageBlockInner\">\n" +
            "                    <table align=\"left\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"mcnImageContentContainer\" style=\"min-width:100%;\">\n" +
            "                        <tbody><tr>\n" +
            "                            <td class=\"mcnImageContent\" valign=\"top\" style=\"padding-right: 9px; padding-left: 9px; padding-top: 0; padding-bottom: 0; text-align:center;\">\n" +
            "                                \n" +
            "                                    \n" +
            "                                        <img align=\"center\" alt=\"\" src=\"{emailLogoLink}\" width=\"196\" style=\"max-width:196px; padding-bottom: 0; display: inline !important; vertical-align: bottom;\" class=\"mcnImage\">\n" +
            "                                    \n" +
            "                                \n" +
            "                            </td>\n" +
            "                        </tr>\n" +
            "                    </tbody></table>\n" +
            "                </td>\n" +
            "            </tr>\n" +
            "    </tbody>\n" +
            "</table></td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td valign=\"top\" id=\"templateHeader\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"mcnDividerBlock\" style=\"min-width:100%;\">\n" +
            "    <tbody class=\"mcnDividerBlockOuter\">\n" +
            "        <tr>\n" +
            "            <td class=\"mcnDividerBlockInner\" style=\"min-width:100%; padding:18px;\">\n" +
            "                <table class=\"mcnDividerContent\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-top: 2px solid #EAEAEA;\">\n" +
            "                    <tbody><tr>\n" +
            "                        <td>\n" +
            "                            <span></span>\n" +
            "                        </td>\n" +
            "                    </tr>\n" +
            "                </tbody></table>\n" +
            "<!--            \n" +
            "                <td class=\"mcnDividerBlockInner\" style=\"padding: 18px;\">\n" +
            "                <hr class=\"mcnDividerContent\" style=\"border-bottom-color:none; border-left-color:none; border-right-color:none; border-bottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; margin-right:0; margin-bottom:0; margin-left:0;\" />\n" +
            "-->\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "    </tbody>\n" +
            "</table></td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td valign=\"top\" id=\"templateBody\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"mcnTextBlock\" style=\"min-width:100%;\">\n" +
            "    <tbody class=\"mcnTextBlockOuter\">\n" +
            "        <tr>\n" +
            "            <td valign=\"top\" class=\"mcnTextBlockInner\" style=\"padding-top:9px;\">\n" +
            "              <!--[if mso]>\n" +
            "<table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"width:100%;\">\n" +
            "<tr>\n" +
            "<![endif]-->\n" +
            "    \n" +
            "<!--[if mso]>\n" +
            "<td valign=\"top\" width=\"600\" style=\"width:600px;\">\n" +
            "<![endif]-->\n" +
            "                <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width:100%; min-width:100%;\" width=\"100%\" class=\"mcnTextContentContainer\">\n" +
            "                    <tbody><tr>\n" +
            "                        \n" +
            "                        <td valign=\"top\" class=\"mcnTextContent\" style=\"padding-top:0; padding-right:18px; padding-bottom:9px; padding-left:18px;\">\n" +
            "                        \n" +
            "                            <h1>{emailHeader}</h1>\n" +
            "\n" +
            "                            {emailContent}\n" +
            "<!-- \n" +
            "<p>If you need a bit of inspiration, you can <a class=\"mc-template-link\" href=\"http://inspiration.mailchimp.com\">see what other MailChimp users are doing</a>, or <a class=\"mc-template-link\" href=\"http://mailchimp.com/resources/email-design-guide/\">learn about email design</a> and blaze your own trail.</p> -->\n" +
            "\n" +
            "                        </td>\n" +
            "                    </tr>\n" +
            "                </tbody></table>\n" +
            "<!--[if mso]>\n" +
            "</td>\n" +
            "<![endif]-->\n" +
            "                \n" +
            "<!--[if mso]>\n" +
            "</tr>\n" +
            "</table>\n" +
            "<![endif]-->\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "    </tbody>\n" +
            "</table></td>\n" +
            "                            </tr>\n" +
            "                            <tr>\n" +
            "                                <td valign=\"top\" id=\"templateFooter\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"mcnTextBlock\" style=\"min-width:100%;\">\n" +
            "    <tbody class=\"mcnTextBlockOuter\">\n" +
            "        <tr>\n" +
            "            <td valign=\"top\" class=\"mcnTextBlockInner\" style=\"padding-top:9px;\">\n" +
            "              <!--[if mso]>\n" +
            "<table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"width:100%;\">\n" +
            "<tr>\n" +
            "<![endif]-->\n" +
            "    \n" +
            "<!--[if mso]>\n" +
            "<td valign=\"top\" width=\"600\" style=\"width:600px;\">\n" +
            "<![endif]-->\n" +
            "                <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width:100%; min-width:100%;\" width=\"100%\" class=\"mcnTextContentContainer\">\n" +
            "                    <tbody><tr>\n" +
            "                        \n" +
            "                        <td valign=\"top\" class=\"mcnTextContent\" style=\"padding-top:0; padding-right:18px; padding-bottom:9px; padding-left:18px;\">\n" +
            "                        \n" +
            "                            <em>Copyright © 20018 MemoryLeak, All rights reserved.</em>\n" +
            "\n" +
            "    <br>\n" +
            "    <strong>Our mailing address is:</strong>\n" +
            "    <br>\n" +
            "    memoryLeak@gmail.com\n" +
            "    <br>\n" +
            "    <br>\n" +
            "Want to change how you receive these emails?<br>\n" +
            "    You can <a href=\"*|UPDATE_PROFILE|*\">update your preferences</a> or <a href=\"*|UNSUB|*\">unsubscribe from this list</a>.\n" +
            "    <br>\n" +
            "    <br>\n" +
            "   \n" +
            "                        </td>\n" +
            "                    </tr>\n" +
            "                </tbody></table>\n" +
            "<!--[if mso]>\n" +
            "</td>\n" +
            "<![endif]-->\n" +
            "                \n" +
            "<!--[if mso]>\n" +
            "</tr>\n" +
            "</table>\n" +
            "<![endif]-->\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "    </tbody>\n" +
            "</table></td>\n" +
            "                            </tr>\n" +
            "                        </table>\n" +
            "<!--[if (gte mso 9)|(IE)]>\n" +
            "</td>\n" +
            "</tr>\n" +
            "</table>\n" +
            "<![endif]-->\n" +
            "                        <!-- // END TEMPLATE -->\n" +
            "                    </td>\n" +
            "                </tr>\n" +
            "            </table>\n" +
            "        </center>\n" +
            "    </body>\n" +
            "</html>\n";
    private static final String newAccountTemplate = "<p>Hello {name}! </p>" +
            "<p>You recently made an account at <a href='http://localhost:8080'>MemoryLeak</a>.</p>" +
            "<p>If you want to use your account, you need to activate it by using this link: <a href='{activateUrl}'>click here</a>.</p>" +
            "<p>If you think you received this email in error, just ignore it. We will not bother you further. </p>";
    private static final String passwordResetTemplate = "<p>Hello {name}! </p>" +
            "<p>You recently requested a password reset for your account at <a href='http://localhost:8080'>MemoryLeak</a>.</p>" +
            "<p>If this request was from you please click on this link: <a href='{resetUrl}'>click here</a>.</p>" +
            "<p>If you think you received this email in error, just ignore it. We will not bother you further. </p>";
    private static final String accountLockedTemplate = "<p>Hello {name}! </p>" +
            "<p>Your account at <a href='http://localhost:8080'>MemoryLeak</a> was locked due to too many failed login attempts..</p>" +
            "<p>If you want to regain access to your account please contact us.</p>" +
            "<p>If you think you received this email in error, just ignore it. We will not bother you further. </p>";
    private static final String newReplyTemplate = "<p>Hello {name}! </p>" +
            "<p>Recently one of your questions at <a href='http://localhost:8080'>MemoryLeak</a> received a new reply.</p>" +
            "<p>If you want to read it, you can go to this link: <a href='{replyUrl}'>click here</a>.</p>" +
            "<p>If you think you received this email in error, just ignore it. We will not bother you further. </p>";
    private static final String classActivityTemplate = "<p>Hello {name}! </p>" +
            "<p>Recently one of the classes that you follow at <a href='http://localhost:8080'>MemoryLeak</a> had some new activity.</p>" +
            "<p>If you want to read it, you can go to this link: <a href='{classUrl}'>click here</a>.</p>" +
            "<p>If you think you received this email in error, just ignore it. We will not bother you further. </p>";

    private JavaMailSender mailSender;

    public Email() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setProtocol("smtp");
        sender.setHost("smtp.gmail.com");
        sender.setPort(587);
        sender.setUsername("memoryleakofficial@gmail.com");
        sender.setPassword("parolaParola");

        Properties mailProps = new Properties();
        mailProps.put("mail.smtps.auth", "true");
        mailProps.put("mail.smtp.starttls.enable", "true");
        mailProps.put("mail.smtp.debug", "true");
        sender.setJavaMailProperties(mailProps);
        this.mailSender = sender;
    }

    public void sendActivationEmail(String email, String name, String activateUrl) {
        try {
            String msg = emailTemplate;
            msg = msg.replace("{emailPreviewText}", "Logo");
            msg = msg.replace("{emailLogoLink}", "https://i.imgur.com/arG54S6.png");
            msg = msg.replace("{emailSubject}", "Welcome!");
            msg = msg.replace("{emailHeader}", "New account!");

            String activate = newAccountTemplate;
            activate = activate.replace("{name}", name);
            activate = activate.replace("{activateUrl}", activateUrl);

            msg = msg.replace("{emailContent}", activate);

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("New account");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("memoryleakofficial@gmail.com");
            helper.setTo(email);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendPasswordResetEmail(String email, String name, String resetUrl) {
        try {
            String msg = emailTemplate;
            msg = msg.replace("{emailPreviewText}", "Logo");
            msg = msg.replace("{emailLogoLink}", "https://i.imgur.com/arG54S6.png");
            msg = msg.replace("{emailSubject}", "Hello!");
            msg = msg.replace("{emailHeader}", "Password reset!");

            String reset = passwordResetTemplate;
            reset = reset.replace("{name}", name);
            reset = reset.replace("{resetUrl}", resetUrl);

            msg = msg.replace("{emailContent}", reset);

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("Password reset");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("memoryleakofficial@gmail.com");
            helper.setTo(email);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendAccountLockedEmail(String userEmail, String username) {
        try {
            String msg = emailTemplate;
            msg = msg.replace("{emailPreviewText}", "Logo");
            msg = msg.replace("{emailLogoLink}", "https://i.imgur.com/arG54S6.png");
            msg = msg.replace("{emailSubject}", "Hello!");
            msg = msg.replace("{emailHeader}", "Account locked!");

            String locked = accountLockedTemplate;
            locked = locked.replace("{name}", username);

            msg = msg.replace("{emailContent}", locked);

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("Account locked");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("memoryleakofficial@gmail.com");
            helper.setTo(userEmail);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void sendNewReplyEmain(String email, String name, String postPage, String replyContent) {
        try {
            String msg = emailTemplate;
            msg = msg.replace("{emailPreviewText}", "Logo");
            msg = msg.replace("{emailLogoLink}", "https://i.imgur.com/arG54S6.png");
            msg = msg.replace("{emailSubject}", "Hello!");
            msg = msg.replace("{emailHeader}", "New reply!");

            String reply = newReplyTemplate;
            reply = reply.replace("{name}", name);
            reply = reply.replace("{replyUrl}", postPage);

            msg = msg.replace("{emailContent}", reply);

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("New reply");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("memoryleakofficial@gmail.com");
            helper.setTo(email);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void sendClassActivityEmain(String email, String name, String classActivity, String replyContent) {
        try {
            String msg = emailTemplate;
            msg = msg.replace("{emailPreviewText}", "Logo");
            msg = msg.replace("{emailLogoLink}", "https://i.imgur.com/arG54S6.png");
            msg = msg.replace("{emailSubject}", "Hello!");
            msg = msg.replace("{emailHeader}", "New class activity!");

            String reply = newReplyTemplate;
            reply = reply.replace("{name}", name);
            reply = reply.replace("{classUrl}", classActivity);

            msg = msg.replace("{emailContent}", reply);

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("Class activity");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("memoryleakofficial@gmail.com");
            helper.setTo(email);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }


}
