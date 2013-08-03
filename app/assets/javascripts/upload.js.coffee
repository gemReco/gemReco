# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".upload-btn").click ->
  $(".gemfile-input").click()
$(".gemfile-input").change ->
  console.log $(@).val()
