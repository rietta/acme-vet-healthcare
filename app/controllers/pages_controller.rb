# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    authorize(self)
  end
end
