class NamespaceController < ApplicationController
  def show
    authorize! :read, @namespace
    @page = @namespace.index_page
    render 'pages/show'
  end
end
