#==========================
# test_string_parser.rb
#==========================
#
# Test suite for string_parser.rb
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
# $Id: test_string_parser.rb 107 2007-02-22 08:34:06Z yohasebe $

if not defined?(LIBPATH)
  LIBPATH  = File.join( File.dirname(__FILE__), '..' ,'lib/rsyntaxtree')
  $LOAD_PATH << LIBPATH
end

require 'pp'
require 'string_parser'
require 'test/unit' unless defined? $ZENTEST and $ZENTEST
class TestStringParser < Test::Unit::TestCase

  def setup
    data = "[S [NP This] [VP [V is] [NP a red pen]]]"
    @sp = StringParser.new(data)
  end  

  def test_auto_subscript
    @sp.parse
    @sp.auto_subscript
    assert_equal("NP_1", @sp.get_elementlist.get_id(2).content)
    assert_equal("NP_2", @sp.get_elementlist.get_id(7).content)
  end
  
  def test_count_node
    assert_equal(nil, @sp.tncnt["NP"])
    @sp.count_node("NP")
    assert_equal(1, @sp.tncnt["NP"])
    @sp.count_node("NP")
    assert_equal(2, @sp.tncnt["NP"])
    @sp.count_node("NP")
    assert_equal(3, @sp.tncnt["NP"])
  end

  def test_data_equals
    data = "[This is   [    a] test [data]  ]"
    sp = StringParser.new(data)
    assert_equal("[This is[ a] test[data] ]", sp.data)
  end

  def test_get_elementlist
    el = @sp.get_elementlist
    assert_instance_of(ElementList, el)
  end

  def test_get_next_token
    numtoken = 0
    puts "Output from test_get_next_token: "
    tk = @sp.get_next_token; numtoken += 1
    while tk != ""
      puts "Token: " + tk
      puts "Position (after): " + @sp.pos.to_s      
      tk = @sp.get_next_token
      numtoken += 1
    end
      puts "Token: " + tk
      puts "Position (after): " + @sp.pos.to_s      
      assert_equal(9 + 1, numtoken)
  end

  def test_make_tree
    puts "Output from test_make_tree [before]:" 
    pp @sp.elist
    @sp.make_tree(0)
    puts "Output from test_make_tree [after]:"     
    pp @sp.elist
    true
  end

  def test_validate
    assert_equal(true, @sp.validate)
    new_sp = StringParser.new("[[this [is] incorrect]")
    assert_equal(false, new_sp.validate)
  end
end

