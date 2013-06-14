# Export Plugin
module.exports = (BasePlugin) ->
  # Define Plugin
  class facebookcommentsPlugin extends BasePlugin
    # Plugin configuration
    name: 'facebookcomments'

    # Template Data Helpers
    templateData:
      # Get Services
      getServices: ->
        services = @site?.services or {}
        return services

      # Get Page Url
      getPageUrl: ->
        pageUrl = (@site.url or '')+@document.url.replace(/\/index.html$/,'').replace(/\/$/,'')
        pageUrl or= '/'  # home pages
        return pageUrl

      # Facebook Comments
      # See https://developers.facebook.com/docs/reference/plugins/comments/
      getFacebookComments: (width,colorscheme,num_posts,order_by) ->
        # Prepare
        services = @getServices()
        facebookApplicationId = services.facebookAppId ? '266367676718271'
        # facebookApplicationId = @site?.services.fbAppId or '266367676718271'
        pageUrl = (@site.url or '')+@document.url.replace(/\/index.html$/,'').replace(/\/$/,'')
        return ''  unless facebookApplicationId

        # @getFacebookComments(arguments). Must be used in the order below:
        # @getFacebookComments(1010, 'dark', 100, 'time')
        # real-world example: <%- @getFacebookComments(1010, 'dark', 100, 'time') %>
        
        # width options: supports only numbers, no '30px' or '100%'
        width = (if typeof width isnt "undefined" then width else '470')
        # colorscheme options: 'light' or 'dark' 
        colorscheme = (if typeof colorscheme isnt "undefined" then colorscheme else 'light')
        num_posts = (if typeof num_posts isnt "undefined" then num_posts else '10')
        # order_by options: 'social', 'reverse_time', 'time'. Default: 'social'
        order_by = (if typeof order_by isnt "undefined" then order_by else 'social')
        # Not implemented: 
        # mobile: whether to show the mobile-optimized version. Default: auto-detect.

        # Return
        return """
          <div id="fb-root"></div>
          <script>(function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=#{escape facebookApplicationId}";
            fjs.parentNode.insertBefore(js, fjs);
          }(document, 'script', 'facebook-jssdk'));</script>
          <div class="fb-comments" data-href="#{pageUrl}" data-width="#{width}" data-num-posts="#{num_posts}" data-colorscheme="#{colorscheme}" data-order-by="#{order_by}"></div>
          """

    # Extend Template Data
    extendTemplateData: (opts) ->
      # Prepare
      {templateData} = opts

      # Inject template helpers into template data
      for own templateHelperName, templateHelper of @templateData
        templateData[templateHelperName] = templateHelper

      # Chain
      @

    # Populate Collections
    # Used to inject our scripts block
    populateCollections: (opts) ->
      # Prepare
      docpad = @docpad
      config = @config
      templateData = docpad.getTemplateData()

      # Chain
      @
