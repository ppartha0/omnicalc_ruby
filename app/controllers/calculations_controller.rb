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
    
    ## Loan Payment formula:
    ## LP = (rP(1+r)^N)/((1+r)^N -1)
    ## if r=0, P/N
    @apr_decimal = @apr/1200
    @months = @years*12
    
    @monthly_payment = (@apr_decimal*@principal*(1+@apr_decimal)**@months)/((1+@apr_decimal)**@months-1)

    # ================================================================================
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
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
    @minutes = (@timediff/60).round(4)
    @hours = (@timediff/(60*60)).round(4)
    @days = (@timediff/(60*60*24)).round(4)
    @weeks = (@timediff/(60*60*24*7)).round(4)
    @years = (@timediff/(60*60*24*365)).round(4)

    # ================================================================================
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort
    @count = @numbers.count
    @sum = @numbers.sum
    @mean = (@sum/@count).round(2)

    @minimum = 1.0
    @maximum = 1.0
    @median = 1.0
    @variance = 1.0
    squared_numbers = []

    @numbers.each do |num|
      if num<@minimum
        @minimum = num
      elsif num>@maximum
        @maximum = num
      end
      demean = (num - @mean)**2
      squared_numbers.push(demean)
    end
    
    ## variance formula: sigsquared = sum(X-mu)^2/N
    @variance = ((squared_numbers.sum)/@count).round(2)
    @standard_deviation = (@variance**0.5).round(2)
    @range = @maximum - @minimum
    
    h = {}
    @numbers.each do |num|
      if h.key? (num)
        h[num] += 1
      else
        h[num] = 1
      end
    end 
    @mode = h.key(h.values.max)
    
    ### median calculation
    if @count % 2 == 0
      ### if the list has an even number of elements, return average of count/2 and count/2 + 1
      index1 = (@count/2) - 1 ### this is because the first index is 0
      index2 = @count/2
      @median = (@sorted_numbers[index1] + @sorted_numbers[index2])/2
    elsif @count % 2 != 0
      index1 = ((@count+1)/2) - 1 ### this is because the first index is 0
      @median = @sorted_numbers[index1]
    end
    
   render("descriptive_statistics.html.erb")
  end
end
