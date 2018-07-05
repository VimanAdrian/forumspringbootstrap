<style>
    .mobile-social-share {
        background: none repeat scroll 0 0 #EEEEEE;
        display: block !important;
        min-height: 70px !important;
        margin: 50px 0;
    }

    .mobile-social-share h3 {
        color: inherit;
        float: left;
        font-size: 15px;
        line-height: 20px;
        margin: 25px 25px 0 25px;
    }

    .share-group {
        float: right;
        margin: 18px 25px 0 0;
    }

    .btn-group {
        display: inline-block;
        font-size: 0;
        position: relative;
        vertical-align: middle;
        white-space: nowrap;
    }

    .mobile-social-share ul {
        float: right;
        list-style: none outside none;
        margin: 0;
        min-width: 61px;
        padding: 0;
    }

    .share {
        min-width: 17px;
    }

    .mobile-social-share li {
        display: block;
        font-size: 18px;
        list-style: none outside none;
        margin-bottom: 3px;
        margin-left: 4px;
        margin-top: 3px;
    }

    .btn-share {
        background-color: #BEBEBE;
        border-color: #CCCCCC;
        color: #333333;
    }

    .btn-twitter {
        background-color: #3399CC !important;
        width: 51px;
        color: #FFFFFF !important;
    }

    .btn-facebook {
        background-color: #3D5B96 !important;
        width: 51px;
        color: #FFFFFF !important;
    }

    .btn-facebook {
        background-color: #3D5B96 !important;
        width: 51px;
        color: #FFFFFF !important;
    }

    .btn-google {
        background-color: #DD3F34 !important;
        width: 51px;
        color: #FFFFFF !important;
    }

    .btn-linkedin {
        background-color: #1884BB !important;
        width: 51px;
        color: #FFFFFF !important;
    }

    .btn-pinterest {
        background-color: #CC1E2D !important;
        width: 51px;
        color: #FFFFFF !important;
    }

    .btn-mail {
        background-color: #FFC90E !important;
        width: 51px;
        color: #FFFFFF !important;
    }

    .caret {
        border-left: 4px solid rgba(0, 0, 0, 0);
        border-right: 4px solid rgba(0, 0, 0, 0);
        border-top: 4px solid;
        display: inline-block;
        height: 0;
        margin-left: 2px;
        vertical-align: middle;
        width: 0;
    }

    #socialShare {
        max-width: 59px;
        margin-bottom: 18px;
    }

    #socialShare > a {
        padding: 6px 10px 6px 10px;
    }

    @media (max-width: 320px) {
        #socialHolder {
            padding-left: 5px;
            padding-right: 5px;
        }

        .mobile-social-share h3 {
            margin-left: 0;
            margin-right: 0;
        }

        #socialShare {
            margin-left: 5px;
            margin-right: 5px;
        }

        .mobile-social-share h3 {
            font-size: 15px;
        }
    }

    @media (max-width: 238px) {
        .mobile-social-share h3 {
            font-size: 12px;
        }
    }

    #dropdownShare {
        padding: 0px 0;
        position: absolute;
        z-index: 10000;
        list-style: none;
        display: none;
    }

    @media only screen and (min-width: 992px) {
        .share-buttons {
            display: none;
        }
    }

    @media only screen and (max-width: 992px) {
        .share-button {
            display: none;
        }
    }
</style>
<p class="margin-bottom-0px buttons-p share-button">
    <button id="dropdownShareButton" class="btn btn-info interaction-button">
        <i class="fas fa-share-alt fa-inverse"></i>
    </button>
</p>

<%--TODO finish this--%>
<ul id="dropdownShare">
    <li>
        <a data-original-title="Twitter" rel="tooltip" class="btn btn-twitter" data-placement="left">
            <i class="fab fa-twitter"></i>
        </a>
    </li>
    <li>
        <a data-original-title="Facebook" rel="tooltip" href="#" class="btn btn-facebook" data-placement="left">
            <i class="fab fa-facebook"></i>
        </a>
    </li>
    <li>
        <a data-original-title="Google+" rel="tooltip" href="#" class="btn btn-google" data-placement="left">
            <i class="fab fa-google-plus"></i>
        </a>
    </li>
    <li>
        <a data-original-title="LinkedIn" rel="tooltip" href="#" class="btn btn-linkedin" data-placement="left">
            <i class="fab fa-linkedin"></i>
        </a>
    </li>
    <li>
        <a data-original-title="Email" rel="tooltip"
           href="mailto:?subject=I wanted you to see this site&amp;body=Check out this site http://www.website.com."
           class="btn btn-mail" data-placement="left">
            <i class="fas fa-envelope"></i>
        </a>
    </li>
</ul>

<p class="margin-bottom-0px buttons-p share-buttons">
    <a data-original-title="Twitter" rel="tooltip" class="btn btn-twitter" data-placement="left">
        <i class="fab fa-twitter"></i>
    </a>
</p>
<p class="margin-bottom-0px buttons-p share-buttons">
    <a data-original-title="Facebook" rel="tooltip" href="#" class="btn btn-facebook" data-placement="left">
        <i class="fab fa-facebook"></i>
    </a>
</p>
<p class="margin-bottom-0px buttons-p share-buttons">
    <a data-original-title="Google+" rel="tooltip" href="#" class="btn btn-google" data-placement="left">
        <i class="fab fa-google-plus"></i>
    </a>
</p>
<p class="margin-bottom-0px buttons-p share-buttons">
    <a data-original-title="LinkedIn" rel="tooltip" href="#" class="btn btn-linkedin" data-placement="left">
        <i class="fab fa-linkedin"></i>
    </a>
</p>
<p class="margin-bottom-0px buttons-p share-buttons">
    <a data-original-title="Email" rel="tooltip"
       href="mailto:?subject=I wanted you to see this site&amp;body=Check out this site http://www.website.com."
       class="btn btn-mail" data-placement="left">
        <i class="fas fa-envelope"></i>
    </a>
</p>

<script>
    $("#dropdownShareButton").click(function () {
        $("#dropdownShare").fadeToggle();
        // e.stopPropagation();
    });

    // $(document).click(function () {
    //     $("#dropdownShare").fadeOut();
    // });

    $(".btn-twitter").click(function () {
        var twitterWindow = window.open('https://twitter.com/share?url=' + document.URL, 'twitter-popup', 'height=350,width=600');
        if (twitterWindow.focus) {
            twitterWindow.focus();
        }
        return false;
    });

    $(".btn-facebook").click(function () {
        var facebookWindow = window.open('https://www.facebook.com/sharer/sharer.php?u=' + document.URL, 'facebook-popup', 'height=350,width=600');
        if (facebookWindow.focus) {
            facebookWindow.focus();
        }
        return false;
    });

    $(".btn-google").click(function () {
        var googleWindow = window.open("https://plus.google.com/share?url=" + document.URL, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=350,width=600');
        if (googleWindow.focus) {
            googleWindow.focus();
        }
        return false;
    });

    $(".btn-linkedin").click(function () {
        var linkedInWindow = window.open("http://www.linkedin.com/shareArticle?mini=true&url=" + document.URL, 'sharer', 'toolbar=0, status=0, width=600, height=350');
        if (linkedInWindow.focus) {
            linkedInWindow.focus();
        }
        return false;
    });
</script>