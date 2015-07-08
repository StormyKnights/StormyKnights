class Piece < ActiveRecord::Base

  belongs_to :game

  # adding scope and delegate to make it easier to navigate between the models
  # scope :pawns, -> { where(type: 'Pawn') } 
  # scope :bishops, -> { where(type: 'Bishop') }
  # scope :knights, -> { where(type: 'Knight') }
  # scope :rooks, -> { where(type: 'Rook') }
  # scope :queens, -> { where(type: 'Queen') }
  # scope :kings, -> { where(type: 'King') }

  # delegate :pawns, :bishops, :knights, :rooks, :queens, :kings, to: :pieces

end
