class Journey 
  attr_reader :entry_station, :exit_station, :journeys
  
  def initialise 
      @entry_station  = nil 
      @exit_station = nil 
      @journey = {} 
  end

 def start_journey(entry_station = "example")
    @entry_station = entry_station
 end 
 
 def finish_journey(exit_station = "example") 
   if @entry_station.nil? 
      @journey = {entry_station: "did not touch in", exit_station: exit_station} 
   end     
   if !@entry_station.nil?
      @journey = {entry_station: entry_station, exit_station: exit_station}
   end 
    #@exit_station = exit_station 
 end 

   def in_journey?
    return true if !@entry_station == nil 
    return false if @entry_station == nil   
  end
end