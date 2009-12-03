#==========================
# rsyntaxtree_controller.rb
#==========================
#
# Controller of Rails interface to RSyntaxTree
#
# This file is part of RSyntaxTree, which is a ruby port of Andre Eisenbach's
# excellent program phpSyntaxTree.
#
# Copyright (c) 2007-2009 Yoichiro Hasebe <yohasebe@gmail.com>
# Copyright (c) 2003-2004 Andre Eisenbach <andre@ironcreek.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

require "rsyntaxtree"

class RsyntaxtreeController < ApplicationController

  def index
   render :layout => false
  end

  def build_query
    @data = params[:data]
    if !@data || @data.empty?
      render(:text => "There is no text to parse")
    end
  end

  def draw_graph
    @tree = SyntaxTree.new params
    image = @tree.render
    disposition = @tree.svg? ? "attachment" : "inline"
    filename = "syntaxtree.#{@tree.format}"
    if image
      send_data image, :disposition => disposition, :filename => filename, :type => @tree.format.to_sym
    else
      render :nothing => true, :status => :unprocessable_entity
    end
    GC.start
  end

  def count_brackets
    text = params['text'].strip
    text_r = text.split(//)
    open_br, close_br = [], []
    text_r.each do |chr|
      if chr == '['
        open_br.push(chr)
      elsif chr == ']'
        close_br.push(chr)
        if open_br.length < close_br.length
          break
        end
      end
    end

    if open_br.length == close_br.length
      message = "&nbsp;"
    else
      message = "Open and close brackets do not match up."
    end

    render(:text => message)
  end

end
