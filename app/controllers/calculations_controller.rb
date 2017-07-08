class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================
    ### strip out any new line characters; remove any punctuation or anything that is not alpha or alphanumeric; then split to create list
    @word_list = @text.downcase.strip.gsub(/[^a-z0-9\s]/i, "").split  
    @word_count = @word_list.count 

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length
    
    @special_word_downcase = @special_word.downcase
    @occurrences =  @word_list.count(@special_word_downcase) ## find the number of @special_word occurrences in @text.split

    # ================================================================================
    # ================================================================================

    render("word_count.html.erb")
  end


  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @starting_time = Time.parse(@starting.to_s)
    @ending_time = Time.parse(@ending.to_s)
    @timediff = @ending_time - @starting_time
    @seconds = @timediff
    @minutes = (@timediff/60).round(2)
    @hours = (@timediff/(60*60)).round(2)
    @days = (@timediff/(60*60*24)).round(2)
    @weeks = (@timediff/(60*60*24*7)).round(2)
    @years = (@timediff/(60*60*24*365)).round(2)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = "Replace this string with your answer."

    @count = "Replace this string with your answer."

    @minimum = "Replace this string with your answer."

    @maximum = "Replace this string with your answer."

    @range = "Replace this string with your answer."

    @median = "Replace this string with your answer."

    @sum = "Replace this string with your answer."

    @mean = "Replace this string with your answer."

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
