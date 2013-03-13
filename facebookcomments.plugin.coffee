# Export Plugin
module.exports = (BasePlugin) ->
  # Define Plugin
  class facebookCommentsPlugin extends BasePlugin
    # Plugin configuration
    name: 'facebookcomments'

    # Template Data Helpers
    templateData:
      
      # Facebook Comments
      # See https://developers.facebook.com/docs/reference/plugins/comments/
      getFacebookComments: ->
        # Prepare
        facebookApplicationId = @site?.services.facebookLikeButton?.applicationId or '266367676718271'
        pageUrl = (@site.url or '')+@document.url.replace(/\/index.html$/,'').replace(/\/$/,'')
        return ''  unless facebookApplicationId
        # Return
        return """
          <meta property="fb:app_id" content="#{facebookApplicationId}"/>
          <div id="fb-root"></div>
          <script>
            window.fbAsyncInit = function() {
              // init the FB JS SDK
              FB.init({
                appId      : '#{facebookApplicationId}', /* App ID from the App Dashboard */
                channelUrl : '#{pageUrl}/fb-comments.html', /* Channel File for x-domain communication */
                status     : true, // check the login status upon init?
                cookie     : true, // set sessions cookies to allow your server to access the session?
                xfbml      : true  // parse XFBML tags on this page?
              });

              // Additional initialization code such as adding Event Listeners goes here

            };

            // Load the SDK's source Asynchronously
            // Note that the debug version is being actively developed and might 
            // contain some type checks that are overly strict. 
            // Please report such bugs using the bugs tool.
            (function(d, debug){
               var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
               if (d.getElementById(id)) {return;}
               js = d.createElement('script'); js.id = id; js.async = true;
               js.src = "//connect.facebook.net/en_US/all" + (debug ? "/debug" : "") + ".js";
               ref.parentNode.insertBefore(js, ref);
             }(document, /*debug*/ false));
          </script>

          <div id="fb-root"></div>
          <script>(function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=#{escape facebookApplicationId}";
            fjs.parentNode.insertBefore(js, fjs);
          }(document, 'script', 'facebook-jssdk'));</script>

          <div class="fb-comments" data-href="#{pageUrl}" data-width="470" data-num-posts="10"></div>
          """

      # Chain
      @
