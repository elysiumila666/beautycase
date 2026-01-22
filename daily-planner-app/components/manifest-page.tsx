"use client"

import { useState } from "react"
import { Plus, X } from "lucide-react"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"

interface VisionNote {
  id: string
  text: string
  style: number
  position: { x: number; y: number }
  rotation: number
}

const noteStyles = [
  {
    id: 0,
    name: "Twine Bow",
    image: "/images/img-3770.jpeg",
  },
  {
    id: 1,
    name: "Black String",
    image: "/images/img-3772.jpeg",
  },
  {
    id: 2,
    name: "Paper Clip",
    image: "/images/img-3775.jpeg",
  },
  {
    id: 3,
    name: "Brass Grommet",
    image: "/images/img-3773.jpeg",
  },
  {
    id: 4,
    name: "Brass Clip",
    image: "/images/img-3776.jpeg",
  },
  {
    id: 5,
    name: "Torn Paper",
    image: "/images/img-3774.jpeg",
  },
]

export function ManifestPage() {
  const [notes, setNotes] = useState<VisionNote[]>([
    {
      id: "1",
      text: "Dream big, start small",
      style: 0,
      position: { x: 8, y: 5 },
      rotation: -3,
    },
    {
      id: "2",
      text: "Travel the world",
      style: 1,
      position: { x: 52, y: 8 },
      rotation: 2,
    },
    {
      id: "3",
      text: "Learn something new every day",
      style: 4,
      position: { x: 20, y: 50 },
      rotation: -1,
    },
  ])
  const [showAddModal, setShowAddModal] = useState(false)
  const [newNoteText, setNewNoteText] = useState("")
  const [selectedStyle, setSelectedStyle] = useState(0)

  const handleAddNote = () => {
    if (!newNoteText.trim()) return

    const newNote: VisionNote = {
      id: Date.now().toString(),
      text: newNoteText,
      style: selectedStyle,
      position: {
        x: Math.random() * 45 + 5,
        y: Math.random() * 40 + 5,
      },
      rotation: Math.random() * 6 - 3,
    }

    setNotes([...notes, newNote])
    setNewNoteText("")
    setShowAddModal(false)
  }

  const handleDeleteNote = (id: string) => {
    setNotes(notes.filter((note) => note.id !== id))
  }

  return (
    <div className="h-full flex flex-col p-3 overflow-hidden relative">
      {/* Header - no calendar needed */}
      <header className="mb-2 flex-shrink-0">
        <h1 className="text-base font-semibold text-stone-800 tracking-tight">Manifest</h1>
        <p className="text-[10px] text-stone-500 mt-0.5">Your vision board for dreams and goals</p>
      </header>

      {/* Vision Board */}
      <div className="flex-1 relative overflow-hidden bg-stone-100/50 rounded-xl">
        {/* Grid background */}
        <div
          className="absolute inset-0 opacity-30"
          style={{
            backgroundImage: `
              linear-gradient(to right, rgba(120,113,108,0.1) 1px, transparent 1px),
              linear-gradient(to bottom, rgba(120,113,108,0.1) 1px, transparent 1px)
            `,
            backgroundSize: "20px 20px",
          }}
        />

        {/* Notes */}
        {notes.map((note) => (
          <div
            key={note.id}
            className="absolute group cursor-pointer"
            style={{
              left: `${note.position.x}%`,
              top: `${note.position.y}%`,
              transform: `rotate(${note.rotation}deg)`,
            }}
          >
            {/* Note card with background image */}
            <div className="relative w-24 h-28">
              <img
                src={noteStyles[note.style].image || "/placeholder.svg"}
                alt=""
                className="absolute inset-0 w-full h-full object-contain"
                crossOrigin="anonymous"
              />
              {/* Text overlay */}
              <div className="absolute inset-0 flex items-center justify-center p-3 pt-6">
                <p className="text-[9px] text-stone-700 text-center font-medium leading-tight">{note.text}</p>
              </div>
              {/* Delete button */}
              <button
                onClick={() => handleDeleteNote(note.id)}
                className="absolute -top-1 -right-1 w-4 h-4 bg-stone-800 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center"
              >
                <X className="size-2.5" />
              </button>
            </div>
          </div>
        ))}

        {/* Empty state */}
        {notes.length === 0 && (
          <div className="absolute inset-0 flex flex-col items-center justify-center text-stone-400">
            <p className="text-xs">Your vision board is empty</p>
            <p className="text-[10px] mt-0.5">Add your dreams and goals</p>
          </div>
        )}
      </div>

      {/* Add Button - bottom right, smaller */}
      <button
        onClick={() => setShowAddModal(true)}
        className="absolute bottom-4 right-4 w-9 h-9 rounded-full bg-stone-800 text-white flex items-center justify-center shadow-lg hover:bg-stone-700 transition-all active:scale-95"
      >
        <Plus className="size-4" />
      </button>

      {/* Add Modal */}
      {showAddModal && (
        <div className="absolute inset-0 bg-black/30 flex items-end justify-center z-50">
          <div className="bg-white rounded-t-2xl w-full p-4 space-y-3">
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-medium text-stone-800">Add to Vision Board</h3>
              <button onClick={() => setShowAddModal(false)} className="p-1 text-stone-400">
                <X className="size-4" />
              </button>
            </div>

            <Input
              placeholder="Write your dream or goal..."
              value={newNoteText}
              onChange={(e) => setNewNoteText(e.target.value)}
              className="text-sm"
              autoFocus
            />

            {/* Style selector */}
            <div>
              <p className="text-[10px] text-stone-500 mb-1.5">Choose a note style</p>
              <div className="flex gap-1.5 overflow-x-auto pb-1">
                {noteStyles.map((style) => (
                  <button
                    key={style.id}
                    onClick={() => setSelectedStyle(style.id)}
                    className={`flex-shrink-0 w-10 h-14 rounded-md overflow-hidden border-2 transition-all ${
                      selectedStyle === style.id ? "border-stone-800" : "border-transparent"
                    }`}
                  >
                    <img
                      src={style.image || "/placeholder.svg"}
                      alt={style.name}
                      className="w-full h-full object-cover"
                      crossOrigin="anonymous"
                    />
                  </button>
                ))}
              </div>
            </div>

            <Button onClick={handleAddNote} disabled={!newNoteText.trim()} className="w-full bg-stone-800">
              Add Note
            </Button>
          </div>
        </div>
      )}
    </div>
  )
}
