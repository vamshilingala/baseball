class StatisticsController < ApplicationController
    #def index
        

    #end
#end
#end
def index
    #column_to_sort=if params[:column_to_sort].present? ? params[:column_to_sort] : "average"
        #sort_order=if params[:sort_order].present? ? params[:sort_order] : "desc"
        #@requirement = Player.where(home_runs: !nil,
         #   rbi: !nil,runs: !nil, at_bats: !nil).order(Arel.sql("#{column_to_sort} #{sort_order}"))

    #Retrieving all the players who have RBI, Home_runs, Runs, At_bats
    #@search = Player.where.not(rbi: nil, home_runs: nil, runs: nil, at_bats: nil).
                          #ransack(params[:q])

    column_to_sort=if params[:column_to_sort].present? ? params[:column_to_sort] : "average"
    end

    sort_order=if params[:sort_order].present? ? params[:sort_order] : "desc"
    end
    @search = Player.where.not(home_runs: nil, rbi: nil,runs: nil, at_bats: nil).order(Arel.sql("#{column_to_sort} #{sort_order}")).ransack(params[:q])

    @players = @search.result(distinct: true).page(params[:page])
    
    



  end

end
