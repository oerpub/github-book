define [
  'jquery'
  'underscore'
  'backbone'
  'cs!./saveable'
  'cs!mixins/loadable'
], ($, _, Backbone, SaveableModel, loadable) ->

  class BaseModel extends SaveableModel
    url: () ->
      if @isNew()
        # POST to `/content/` if new
        return '/api/content/'
      else
        # GET/PUT with the id in the URL if it is not new content
        return "/api/content/#{ @id }"

    mediaType: 'application/vnd.org.cnx.module'

    getTitle: (container) ->
      if @unique
        title = @get('title')
      else
        title = container?.getTitle?(@) or @get('title')

      return title

    setTitle: (container, title) ->
      if @unique
        @set('title', title)
      else
        container?.setTitle?(@, title) or @set('title', title)

  # Mix in the loadable methods
  BaseModel = BaseModel.extend loadable
  return BaseModel
