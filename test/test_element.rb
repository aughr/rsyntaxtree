#==========================
# test_element.rb
#==========================
#
# Test suite for element.rb
# 
# This file is part of RSyntaxTree, which is a ruby port of Andre Eisenbach's
# excellent program phpSyntaxTree.
#
# Copyright (c) 2007      Yoichiro Hasebe <yohasebe@gmail.com>
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
#
# $Id: test_element.rb 107 2007-02-22 08:34:06Z yohasebe $

if not defined?(LIBPATH)
  LIBPATH  = File.join( File.dirname(__FILE__), '..' ,'lib/rsyntaxtree')
  $LOAD_PATH << LIBPATH
end

require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'element'
class TestElement < Test::Unit::TestCase

  def setup
    @element = Element.new(id = 0, parent = -1, content = "a noun phrase", level = 0, type = ETYPE_NODE)  
  end
  
  def test_content
    assert_not_equal("a verb phrase", @element.content)
    assert_equal("a noun phrase", @element.content)
   end

  def test_dump
    puts "Output from Element#dump:"
    @element.dump
    true   
  end

  def test_id
    assert_not_equal(1, @element.id)
    assert_equal(0, @element.id)
  end

  def test_indent
    assert_not_equal(1, @element.indent)
    assert_equal(0, @element.indent)
  end

  def test_level
    assert_not_equal(1, @element.level)
    assert_equal(0, @element.level)    
  end

  def test_parent
    assert_not_equal(0, @element.parent)
    assert_equal(-1, @element.parent)    
  end

  def test_type
    assert_not_equal(0, @element.type)
    assert_equal(ETYPE_NODE, @element.type)    
  end

  def test_width
    assert_not_equal(1, @element.width)
    assert_equal(0, @element.width)    
  end
end

