class Api::V1::GadgetsController < ApplicationController

  def index
    if !params[:address].blank?
      #gadgets = Gadget.where(active: true).near(params[:address], 5, order: 'distance')
      #TODO
      gadgets = Gadget.where(active: true)
    else
      gadgets = Gadget.where(active: true)
    end

    if !params[:start_date].blank? && !params[:end_date].blank?
      start_date = DateTime.parse(params[:start_date])
      end_date = DateTime.parse(params[:end_date])

      gadgets = gadgets.select { |gadget|
          # Check #1: Check if there are any approved reservations overlap this date range
          reservations = Reservation.where(
            "gadget_id = ? AND (start_date <= ? AND end_date >= ?) AND status = ?",
            gadget.id, end_date, start_date, 1
          ).count

          #TODO
          # Check #2: Check if there are any unavailable dates within that date range
          #calendars = Calendar.where(
          #  "gadget_id = ? AND status = ? and day BETWEEN ? AND ?",
          #  gadget.id, 1, start_date, end_date
          #).count

          #reservations == 0 && calendars == 0
          reservations == 0
      }
    end

    render json: {
      gadgets: gadgets.map { |gadget| gadget.attributes.merge(image: gadget.cover_photo('medium'), instant: gadget.instant != "Request") },
      is_success: true
    }, status: :ok

  end

  def show
    if Gadget.exists?(id: params[:id])
      gadget = Gadget.find(params[:id])
    else
      render json: {error: "Invalid ID", is_success: false}, status: 422
      return
    end

    today = Date.today
    reservations = Reservation.where(
      "gadget_id = ? AND (start_date >= ? AND end_date >= ?) AND status = ?",
      params[:id], today, today, 1
    )
    unavailable_dates = reservations.map { |r|
      (r[:start_date].to_datetime...r[:end_date].to_datetime).map { |day| day.strftime("%Y-%m-%d") }
    }.flatten.to_set
    #calendars = Calendar.where(
    #      "gadget_id = ? and status = ? and day >= ?",
    #      params[:id], 1, today
    #    ).pluck(:day).map(&:to_datetime).map { |day| day.strftime("%Y-%m-%d") }.flatten.to_set

    #unavailable_dates.merge calendars

    if !gadget.nil?
      gadget_serializer = GadgetSerializer.new(
        gadget,
        image: gadget.cover_photo('medium'),
        unavailable_dates: unavailable_dates
      )
      render json: { gadget: gadget_serializer, is_success: true}, status: :ok
    else
      render json: {error: "Invalid ID", is_success: false}, status: 422
    end
  end

  def your_listings
    gadgets = current_user.gadgets
    render json: {
      gadgets: gadgets.map { |r| r.attributes.merge(image: r.cover_photo('medium'), instant: r.instant != "Request") },
      is_success: true
    }, status: :ok

  end

end
