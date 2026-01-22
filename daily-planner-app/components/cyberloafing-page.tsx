"use client"

import type React from "react"

import { useState } from "react"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { UrlCard, type UrlCardData } from "@/components/url-card"
import { Plus, Link, ImageIcon, Mic, X } from "lucide-react"

type ContentType = "media" | "link" | "audio"

export function CyberloafingPage() {
  const [cards, setCards] = useState<UrlCardData[]>([])
  const [urlInput, setUrlInput] = useState("")
  const [isLoading, setIsLoading] = useState(false)
  const [showInput, setShowInput] = useState(false)
  const [contentType, setContentType] = useState<ContentType>("link")
  const [showAddMenu, setShowAddMenu] = useState(false)
  const [savedSources, setSavedSources] = useState<string[]>([])
  const [savedAuthors, setSavedAuthors] = useState<string[]>([])
  const [savedCategories, setSavedCategories] = useState<string[]>([])

  const handleAddUrl = async () => {
    if (!urlInput.trim()) return

    setIsLoading(true)

    const newCard: UrlCardData = {
      id: Date.now().toString(),
      url: urlInput,
      title: extractTitleFromUrl(urlInput),
      thumbnail: `/placeholder.svg?height=80&width=120&query=${encodeURIComponent(getDomainFromUrl(urlInput))}`,
      source: "",
      author: "",
      category: "",
      type: contentType,
    }

    setCards([...cards, newCard])
    setUrlInput("")
    setShowInput(false)
    setShowAddMenu(false)
    setIsLoading(false)
  }

  const handleUpdateCard = (id: string, updates: Partial<UrlCardData>) => {
    setCards(cards.map((card) => (card.id === id ? { ...card, ...updates } : card)))

    if (updates.source && updates.source.trim() && !savedSources.includes(updates.source)) {
      setSavedSources([...savedSources, updates.source])
    }
    if (updates.author && updates.author.trim() && !savedAuthors.includes(updates.author)) {
      setSavedAuthors([...savedAuthors, updates.author])
    }
    if (updates.category && updates.category.trim() && !savedCategories.includes(updates.category)) {
      setSavedCategories([...savedCategories, updates.category])
    }
  }

  const handleDeleteSource = (source: string) => {
    setSavedSources(savedSources.filter((s) => s !== source))
    setCards(cards.map((card) => (card.source === source ? { ...card, source: "" } : card)))
  }

  const handleDeleteAuthor = (author: string) => {
    setSavedAuthors(savedAuthors.filter((a) => a !== author))
    setCards(cards.map((card) => (card.author === author ? { ...card, author: "" } : card)))
  }

  const handleDeleteCategory = (category: string) => {
    setSavedCategories(savedCategories.filter((c) => c !== category))
    setCards(cards.map((card) => (card.category === category ? { ...card, category: "" } : card)))
  }

  const handleDeleteCard = (id: string) => {
    setCards(cards.filter((card) => card.id !== id))
  }

  const extractTitleFromUrl = (url: string): string => {
    try {
      const urlObj = new URL(url)
      const pathname = urlObj.pathname
      const segments = pathname.split("/").filter(Boolean)
      if (segments.length > 0) {
        return segments[segments.length - 1]
          .replace(/[-_]/g, " ")
          .replace(/\.\w+$/, "")
          .split(" ")
          .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
          .join(" ")
      }
      return urlObj.hostname
    } catch {
      return "Untitled Link"
    }
  }

  const getDomainFromUrl = (url: string): string => {
    try {
      const urlObj = new URL(url)
      return urlObj.hostname.replace("www.", "")
    } catch {
      return "unknown"
    }
  }

  const contentTypes: { type: ContentType; label: string; icon: React.ReactNode; placeholder: string }[] = [
    { type: "media", label: "Media", icon: <ImageIcon className="size-3.5" />, placeholder: "Paste image/video URL..." },
    { type: "link", label: "Link", icon: <Link className="size-3.5" />, placeholder: "Paste URL here..." },
    { type: "audio", label: "Audio", icon: <Mic className="size-3.5" />, placeholder: "Paste audio URL..." },
  ]

  const selectedTypeInfo = contentTypes.find((t) => t.type === contentType)

  const handleSelectType = (type: ContentType) => {
    setContentType(type)
    setShowAddMenu(false)
    setShowInput(true)
  }

  return (
    <div className="h-full flex flex-col p-3 overflow-hidden relative">
      {/* Header */}
      <header className="mb-3 flex-shrink-0">
        <h1 className="text-base font-semibold text-stone-800 tracking-tight">Cyberloafing</h1>
        <p className="text-[10px] text-stone-500 mt-0.5">Record your daily aha moments</p>
      </header>

      {/* Cards Container */}
      <div className="flex-1 overflow-y-auto space-y-2 pb-14 pr-1">
        {cards.length === 0 ? (
          <div className="h-full flex flex-col items-center justify-center text-stone-400">
            <Link className="size-8 mb-2 opacity-30" />
            <p className="text-xs">No content saved yet</p>
            <p className="text-[10px] mt-0.5">Tap + to capture your first aha moment</p>
          </div>
        ) : (
          cards.map((card) => (
            <UrlCard
              key={card.id}
              data={card}
              onUpdate={handleUpdateCard}
              onDelete={handleDeleteCard}
              savedSources={savedSources}
              savedAuthors={savedAuthors}
              savedCategories={savedCategories}
              onDeleteSource={handleDeleteSource}
              onDeleteAuthor={handleDeleteAuthor}
              onDeleteCategory={handleDeleteCategory}
            />
          ))
        )}
      </div>

      {/* Input Modal */}
      {showInput && (
        <div className="absolute inset-0 bg-black/30 flex items-end justify-center z-50">
          <div className="bg-white rounded-t-2xl w-full p-4 space-y-3">
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-medium text-stone-800">Add {selectedTypeInfo?.label}</h3>
              <button onClick={() => setShowInput(false)} className="p-1 text-stone-400">
                <X className="size-4" />
              </button>
            </div>
            <Input
              placeholder={selectedTypeInfo?.placeholder}
              value={urlInput}
              onChange={(e) => setUrlInput(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && handleAddUrl()}
              className="text-sm"
              autoFocus
            />
            <Button onClick={handleAddUrl} disabled={isLoading || !urlInput.trim()} className="w-full bg-stone-800">
              Add {selectedTypeInfo?.label}
            </Button>
          </div>
        </div>
      )}

      {/* Arc Menu for Add Button - centered around the button */}
      {showAddMenu && (
        <>
          {/* Backdrop */}
          <div className="absolute inset-0 z-30" onClick={() => setShowAddMenu(false)} />
          
          {/* Arc buttons - positioned relative to the add button */}
          <div className="absolute bottom-4 right-4 z-40">
            {contentTypes.map((item, index) => {
              // Arc arrangement: buttons spread above and to the left of the + button
              // Using angles: -135deg (top-left), -90deg (top), -45deg (top-right)
              const angles = [-135, -90, -45]
              const angle = angles[index]
              const radius = 56
              const x = Math.cos((angle * Math.PI) / 180) * radius
              const y = Math.sin((angle * Math.PI) / 180) * radius

              return (
                <button
                  key={item.type}
                  onClick={() => handleSelectType(item.type)}
                  className="absolute w-9 h-9 rounded-full bg-white shadow-md flex items-center justify-center text-stone-600 hover:bg-stone-50 transition-all active:scale-95"
                  style={{
                    left: `${x - 18 + 20}px`,
                    top: `${y - 18 + 20}px`,
                    animationName: "popIn",
                    animationDuration: "0.2s",
                    animationTimingFunction: "ease-out",
                    animationFillMode: "both",
                    animationDelay: `${index * 0.04}s`,
                  }}
                >
                  {item.icon}
                </button>
              )
            })}
          </div>
        </>
      )}

      {/* Add Button - bottom right, smaller */}
      <button
        onClick={() => setShowAddMenu(!showAddMenu)}
        className={`absolute bottom-4 right-4 w-9 h-9 rounded-full bg-stone-800 text-white flex items-center justify-center shadow-lg transition-all active:scale-95 z-40 ${
          showAddMenu ? "rotate-45" : ""
        }`}
      >
        <Plus className="size-4" />
      </button>

      <style jsx>{`
        @keyframes popIn {
          from {
            opacity: 0;
            transform: scale(0.5);
          }
          to {
            opacity: 1;
            transform: scale(1);
          }
        }
      `}</style>
    </div>
  )
}
