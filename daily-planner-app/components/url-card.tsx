"use client"

import type React from "react"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Tag, AtSign, FolderOpen, X, ExternalLink } from "lucide-react"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"

export interface UrlCardData {
  id: string
  url: string
  title: string
  thumbnail: string
  source: string
  author: string
  category: string
  type?: "link" | "image" | "document" | "media" | "audio"
}

interface UrlCardProps {
  data: UrlCardData
  onUpdate: (id: string, updates: Partial<UrlCardData>) => void
  onDelete: (id: string) => void
  savedSources: string[]
  savedAuthors: string[]
  savedCategories: string[]
  onDeleteSource: (source: string) => void
  onDeleteAuthor: (author: string) => void
  onDeleteCategory: (category: string) => void
}

export function UrlCard({
  data,
  onUpdate,
  onDelete,
  savedSources,
  savedAuthors,
  savedCategories,
  onDeleteSource,
  onDeleteAuthor,
  onDeleteCategory,
}: UrlCardProps) {
  const [editingField, setEditingField] = useState<string | null>(null)
  const [tempValue, setTempValue] = useState("")

  const handleSave = (field: "source" | "author" | "category") => {
    onUpdate(data.id, { [field]: tempValue })
    setEditingField(null)
    setTempValue("")
  }

  const handleSelectSaved = (field: "source" | "author" | "category", value: string) => {
    onUpdate(data.id, { [field]: value })
    setEditingField(null)
    setTempValue("")
  }

  const openEditPopover = (field: "source" | "author" | "category", currentValue: string) => {
    setTempValue(currentValue)
    setEditingField(field)
  }

  const renderTagButton = (
    field: "source" | "author" | "category",
    icon: React.ReactNode,
    label: string,
    savedOptions: string[],
    onDeleteOption: (value: string) => void,
  ) => (
    <Popover open={editingField === field} onOpenChange={(open) => !open && setEditingField(null)}>
      <PopoverTrigger asChild>
        <button
          className="h-5 px-1.5 text-[10px] rounded bg-stone-100 text-stone-500 flex items-center gap-0.5 hover:bg-stone-200 transition-colors"
          onClick={() => openEditPopover(field, data[field])}
        >
          {icon}
          <span className="max-w-[50px] truncate">{data[field] || label}</span>
        </button>
      </PopoverTrigger>
      <PopoverContent className="w-48 p-2" align="start">
        <div className="space-y-2">
          {savedOptions.length > 0 && (
            <div className="space-y-1">
              <p className="text-[10px] text-stone-400 px-1">Saved</p>
              <div className="flex flex-wrap gap-1">
                {savedOptions.map((option) => (
                  <div key={option} className="group flex items-center">
                    <button
                      onClick={() => handleSelectSaved(field, option)}
                      className="h-5 px-1.5 text-[10px] bg-stone-100 hover:bg-stone-200 rounded-l transition-colors"
                    >
                      {option}
                    </button>
                    <button
                      onClick={() => onDeleteOption(option)}
                      className="h-5 px-1 text-[10px] bg-stone-100 hover:bg-red-100 hover:text-red-600 rounded-r transition-colors"
                    >
                      <X className="size-2.5" />
                    </button>
                  </div>
                ))}
              </div>
            </div>
          )}
          <div className="flex gap-1">
            <Input
              placeholder={`New ${label.toLowerCase()}...`}
              value={tempValue}
              onChange={(e) => setTempValue(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && handleSave(field)}
              className="h-6 text-[10px]"
              autoFocus
            />
            <Button size="sm" className="h-6 px-2 text-[10px] bg-stone-800" onClick={() => handleSave(field)}>
              OK
            </Button>
          </div>
        </div>
      </PopoverContent>
    </Popover>
  )

  return (
    <div className="group relative bg-white border border-stone-200 rounded-lg overflow-hidden transition-shadow hover:shadow-md">
      {/* Delete Button */}
      <button
        onClick={() => onDelete(data.id)}
        className="absolute top-1.5 right-1.5 z-10 opacity-0 group-hover:opacity-100 transition-opacity bg-white/80 backdrop-blur-sm rounded-full p-0.5 hover:bg-red-500 hover:text-white"
      >
        <X className="size-3" />
      </button>

      {/* Horizontal layout: thumbnail on left, content on right */}
      <div className="flex">
        {/* Thumbnail */}
        <div className="relative w-20 h-16 flex-shrink-0 bg-stone-100">
          <img src={data.thumbnail || "/placeholder.svg"} alt={data.title} className="w-full h-full object-cover" />
          <a
            href={data.url}
            target="_blank"
            rel="noopener noreferrer"
            className="absolute bottom-1 right-1 bg-white/80 backdrop-blur-sm rounded-full p-1 hover:bg-stone-800 hover:text-white transition-colors"
          >
            <ExternalLink className="size-2.5" />
          </a>
        </div>

        {/* Content */}
        <div className="flex-1 p-2 min-w-0">
          <h3 className="font-medium text-[11px] text-stone-800 line-clamp-1 mb-1.5">{data.title}</h3>

          {/* Tag Buttons - all in one row */}
          <div className="flex items-center gap-1 flex-wrap">
            {renderTagButton("source", <Tag className="size-2.5" />, "from", savedSources, onDeleteSource)}
            {renderTagButton("author", <AtSign className="size-2.5" />, "who", savedAuthors, onDeleteAuthor)}
            {renderTagButton(
              "category",
              <FolderOpen className="size-2.5" />,
              "category",
              savedCategories,
              onDeleteCategory,
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
