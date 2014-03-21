class PagesController < ApplicationController
  def drafts
    @ideas = Idea.all
    @bdrafts = true
  end
end
