class  Valet

        # These are variales are used to keep track of the car spaces and to keep track of
        # which car is located where right at the moment.
        # small => Total amount of car space available for small cars 
        # medium =>  Total amount of car space available for medium cars 
        # large =>  Total amount of car space available for large cars
        # sc => Keeps track of how many Small cars are parked in Small Parking Space
        # scm => Keeps track of how many Small cars are parked in Medium Parking Space
        # scl => Keeps track of how many Small cars are parked in Large Parking Space 
        # mc => Keeps track of how many Medium cars are parked in Medium Parking Space
        # mcl => Keeps track of how many Medium cars are parked in Large Parking Space
        # lc => Keeps track of how many Large cars are parked in Large Parking Space
    attr_accessor :small ,:medium ,:large,:sc,:scm,:scl,:mc,:mcl,:lc

        # These hash stores the data of car placed at which parking spaces
        # values_small => Keeps track of all the car in Small Parking Space
        # values_medium => Keeps track of all the car in Medium Parking Space
        # values_large => Keeps track of all the car in Large Parking Space   
    attr_accessor :values_small, :values_large, :values_medium

        # Constructor initialize the neccessary values for the decalarration of the object 
    def initialize(s=nil,m=nil,l=nil)
        @small=s.to_i
        @medium=m.to_i
        @large=l.to_i
        @sc=@scm=@scl=@mc=@mcl=@lc=0
        @values_small=Hash.new()
        @values_medium=Hash.new()
        @values_large=Hash.new()
    end
        # AdmitTheCar is a recursive function which take care of addition of new records 
        # as well as the updation of old record 
    def AdmitTheCar(licensePlateNumber,carSize)
        return puts "Failure" if @small+@medium+@large == @sc+@scm+@scl+@mc+@mcl+@lc

        if(carSize == "Small")
            if(@sc<@small)
                @values_small[licensePlateNumber] = carSize
                @sc+=1
                return puts "Success"
            end
            if(@scm+@mc<@medium)
                @values_medium[licensePlateNumber]=carSize
                @scm+=1
                return puts "Success"
            end
            if(@scl+@lc+@mcl<@large)
                @values_large[licensePlateNumber]=carSize
                @scl+=1
                return puts "Success"
            end
  
        end    

        if (carSize == "Medium")
            if(@scm+@mc<@medium) 
                @values_medium[licensePlateNumber]=carSize
                @mc+=1
                return puts "Success"
            end

            if(@scl+@lc+@mcl<@large)
                @values_large[licensePlateNumber]=carSize
                @mcl+=1
                return puts "Success"
            end

            if(@scm>0 && @sc<@small)
                lps = @value_medium.key("Small")
                @scm-=1
                @value_medium.delete("Small")
                AdmitTheCar(lps,"Small")
            elsif(@scl>0 && @sc<@small)
                lps = @values_large.key("Small")
                @scl-=1
                @values_large.delete("Small")
                AdmitTheCar(lps,"Small")            
            else
                return puts "Failure"
            end    
            AdmitTheCar(licensePlateNumber,carSize)
        end

        if(carSize == "Large")
            if(@scl+@lc+@mcl<@large)
                @values_large[licensePlateNumber]=carSize
                @lc+=1
                return puts "Success"
            end

            if(@scl>0)
                lp = @values_large.key("Small")
                if(@sc<@small)
                    @scl-=1
                elsif(@scm+@mc<@medium)
                    @scl-=1
                else
                    return puts "Failure"
                end
                @values_large.delete(lp)
                AdmitTheCar(lp,"Small")
            elsif(@mcl>0)
                lp = @values_large.key("Medium")
                if(@mc+@scm<@medium)
                    @mcl-=1
                    @values_large.delete(lp)
                    AdmitTheCar(lp,"Medium")
                elsif(@scm > 0 && @sc<@small)
                    lps = @values_medium.key("Small")
                    @scm-=1
                    @values_medium.delete("Small")
                    AdmitTheCar(lps,"Small")
                    @values_large.delete(lp,"Medium")
                    AdmitTheCar(lp,"Medium")
                end    
            else
                return puts "Failure"
            end
            AdmitTheCar(licensePlateNumber,carSize)
            
        end


    end
        # ExitTheCar function take cares of deletion of the car when it leaves the garage
    def ExitTheCar(licensePlateNumber)

        if(@values_small[licensePlateNumber])
            @values_small.delete(licensePlateNumber)
            @sc-=1
            return puts "Success"

        end

        if(@values_medium[licensePlateNumber])
            val = @values_medium[licensePlateNumber]
            if(val=="Small")
                @scm-=1
            else
                @mc-=1
            end
            @values_medium.delete(licensePlateNumber)
            return puts "Success"

        end
        
        if(@values_large[licensePlateNumber])
            val= @values_large[licensePlateNumber]
            if(val=="Small")
                @scl-=1
            end
            if(val=="Medium")
                @mcl-=1
            else
                @lc-=1
            end
            @values_large.delete[licensePlateNumber]
            return puts "Success"
        end

        return puts "Failure"
    end
end

# NOTE:   For representing the small cars size use "Small" key word
#         For representing the medium cars size use "Medium" key word
#         For representing the large cars size use "Large" key word

#Gets the Requires Input from the user and only enter numerical decimal values
puts("Enter no.of small parking")
x=gets.chomp
puts("Enter the no.of medium parking")
y=gets.chomp
puts("Enter the no.of large parking")
z=gets.chomp

# Initializing the variale with the class object
parking = Valet.new(x,y,z)

# A loop to perform the required actions for Valet Class
while (true)
    puts("Choices :")
    puts("1 to add new Car")
    puts("2 Delete Car")
    puts("3 To Exit")
    choice=gets.chomp.to_i
    puts(" ")
    if choice == 1
        puts("Enter the license plate nubmer to be added:")
        lp=gets.chomp
        puts("Enter the car size :")
        size=gets.chomp
        puts(" ")
        parking.AdmitTheCar(lp,size)
    elsif choice == 2
        puts("Enter the license plate nubmer to be deleted:")
        lp=gets.chomp
        puts(" ")
        parking.ExitTheCar(lp)
    elsif choice == 3
        exit()
    else 
        puts("Enter the a valid option")
    end
end
          


