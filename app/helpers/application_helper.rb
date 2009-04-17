require 'md5'
module ApplicationHelper
  def feed_icon_tag(title, url)
    (@feed_icons ||= []) << { :url => url, :title => title }
    link_to image_tag('feed-icon.png', :size => '14x14', :alt => "Subscribe to #{title}"), url
  end

  def pagination(collection)
    if collection.total_entries > 1
      "<p class='pages'>" + 'Pages'[:pages_title] + ": <strong>" + 
      will_paginate(collection, :inner_window => 10, :next_label => "next"[], :prev_label => "previous"[]) +
      "</strong></p>"
    end
  end
  
  def next_page(collection)
    unless collection.current_page == collection.total_entries or collection.total_entries == 0
      "<p style='float:right;'>" + link_to("Next page"[], { :page => collection.current_page.next }.merge(params.reject{|k,v| k=="page"})) + "</p>"
    end
  end

  def search_posts_title
    returning(params[:q].blank? ? t(:recent_posts) : t(:searching_for) + " '#{h params[:q]}'") do |title|
      title << " "+ t(:user) + ': {user}'[:by_user,h(@user.display_name)] if @user
      title << " "+ t(:in) + ' {forum}'[:in_forum,h(@forum.name)] if @forum
    end
  end

  def topic_title_link(topic, options)
    if topic.title =~ /^\[([^\]]{1,15})\]((\s+)\w+.*)/
      "<span class='flag'>#{$1}</span>" + 
      link_to(h($2.strip), forum_topic_path(@forum, topic), options)
    else
      link_to(h(topic.title), forum_topic_path(@forum, topic), options)
    end
  end

  def ajax_spinner_for(id, spinner="spinner.gif")
    "<img src='/images/#{spinner}' style='display:none; vertical-align:middle;' id='#{id.to_s}_spinner'> "
  end

  def avatar_for(user, size=32)
    image_tag "http://www.gravatar.com/avatar.php?gravatar_id=#{MD5.md5(user.email)}&rating=PG&size=#{size}", :size => "#{size}x#{size}", :class => 'photo'
  end

  def search_path(atom = false)
    options = params[:q].blank? ? {} : {:q => params[:q]}
    prefix = 
      if @topic
        options.update :topic_id => @topic, :forum_id => @forum
        :forum_topic
      elsif @forum
        options.update :forum_id => @forum
        :forum
      elsif @user
        options.update :user_id => @user
        :user
      else
        :search
      end
    atom ? send("formatted_#{prefix}_posts_path", options.update(:format => :atom)) : send("#{prefix}_posts_path", options)
  end

  @@default_jstime_format = "%d %b, %Y %I:%M %p"
  def jstime(time, format = nil)
    content_tag 'span', time.strftime(format || @@default_jstime_format), :class => 'time'
  end

  def for_moderators_of(record, &block)
    moderator_of?(record) && concat(capture(&block))
  end

  def main_site
    @main_site ||= Site.find(:first)
  end
  
  def main_site_name
    @main_site_name ||= main_site ? @main_site.name :
      "Altered Beast"
  end

  def main_site_description
    @main_site_description ||= main_site ? @main_site.description :
      "<h5>What is Beast?</h5><p>A small, light-weight forum in Rails with a scary name and a goal of around 500 lines of code when we're done.</p>"
  end

  def main_site_tagline
    @main_site_tagline ||= main_site ? @main_site.tagline :
      "Two's company. Three's a forum. More's a Beast."
  end

end
