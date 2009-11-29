#==========================
# test_elementlist.rb
#==========================
#
# Test suite for elementlist.rb
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
# $Id: test_elementlist.rb 107 2007-02-22 08:34:06Z yohasebe $

if not defined?(LIBPATH)
  LIBPATH  = File.join( File.dirname(__FILE__), '..' ,'lib/rsyntaxtree')
  $LOAD_PATH << LIBPATH
end

require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'elementlist'
class TestElementList < Test::Unit::TestCase

  def setup
    @el = ElementList.new
    @element1 = Element.new(id = 1, parent = 0, content = "NP", level = 0, type = ETYPE_LEAF)
    @element2 = Element.new(id = 2, parent = 1, content = "a noun", level = 1, type = ETYPE_LEAF)
    
  end
  
  def test_add
    @el.add(@element1)
    @el.add(@element2)
    assert_equal(ETYPE_NODE, @element1.type)
  end

  def test_get_indent
    @el.add(@element1)
    assert_equal(0, @el.get_indent(1))
  end

  def test_get_child_count
    @el.add(@element1)
    @el.add(@element2)
    assert_equal(1, @el.get_child_count(1))
  end

  def test_get_children
    @el.add(@element1)
    @el.add(@element2)
    assert_same(2, @el.get_children(1)[0])
  end

  def test_get_element_width
    @el.add(@element1)
    assert_equal(0, @el.get_element_width(1))
    assert_equal(-1,@el.get_element_width(2))
  end

  def test_get_first
    assert_nil(@el.get_first)
    @el.add(@element1)
    @el.add(@element2)
    assert_equal(@element1, @el.get_first)
    assert_equal(0, @el.iterator)
  end

  def test_get_id
    @el.add(@element1)
    @el.add(@element2)
    assert_equal(@element1, @el.get_id(1))
    assert_equal(@element2, @el.get_id(2)) 
  end

  def test_get_level_height
    @el.add(@element1)
    @el.add(@element2)
    assert_equal(2, @el.get_level_height)
  end

  def test_get_next
    @el.add(@element1)
    @el.add(@element2)
    first = @el.get_first
    assert_same(@element1, first)
    second = @el.get_next
    assert_same(@element2, second)
    assert_equal(1, @el.iterator)
  end

  def test_set_element_width
    @el.add(@element1)
    @el.set_element_width(1, 50)
    assert_equal(50, @el.get_element_width(1))
  end

  def test_set_indent
    @el.add(@element1)
    @el.set_indent(1, 5)
    assert_equal(5, @el.get_indent(1))
  end
end

