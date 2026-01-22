"use client"

import type React from "react"

import { useState, useRef } from "react"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Checkbox } from "@/components/ui/checkbox"
import { Button } from "@/components/ui/button"
import { Sparkles, Lightbulb, PenLine } from "lucide-react"

type JournalType = "gratitude" | "inspiration" | "diary"

interface Frog {
  id: string
  text: string
  completed: boolean
}

interface TimeBlock {
  morning: string
  afternoon: string
  evening: string
}

export function DailyCareerPage() {
  const [frogs, setFrogs] = useState<Frog[]>([
    { id: "1", text: "", completed: false },
    { id: "2", text: "", completed: false },
    { id: "3", text: "", completed: false },
  ])
  const [timeBlocks, setTimeBlocks] = useState<TimeBlock>({
    morning: "",
    afternoon: "",
    evening: "",
  })
  const [journalType, setJournalType] = useState<JournalType>("gratitude")
  const [journalContent, setJournalContent] = useState("")
  const [activeTimeBlock, setActiveTimeBlock] = useState(0)
  const timeBlockRef = useRef<HTMLDivElement>(null)
  const [touchStart, setTouchStart] = useState<number | null>(null)
  const [touchEnd, setTouchEnd] = useState<number | null>(null)

  const updateFrog = (id: string, updates: Partial<Frog>) => {
    setFrogs(frogs.map((frog) => (frog.id === id ? { ...frog, ...updates } : frog)))
  }

  const timeBlockKeys = ["morning", "afternoon", "evening"] as const
  const timeBlockLabels = ["Morning", "Afternoon", "Evening"]

  const handleTimeBlockTouchStart = (e: React.TouchEvent) => {
    setTouchEnd(null)
    setTouchStart(e.targetTouches[0].clientX)
  }

  const handleTimeBlockTouchMove = (e: React.TouchEvent) => {
    setTouchEnd(e.targetTouches[0].clientX)
  }

  const handleTimeBlockTouchEnd = () => {
    if (!touchStart || !touchEnd) return
    const distance = touchStart - touchEnd
    const minSwipeDistance = 50

    if (distance > minSwipeDistance && activeTimeBlock < 2) {
      setActiveTimeBlock(activeTimeBlock + 1)
    }
    if (distance < -minSwipeDistance && activeTimeBlock > 0) {
      setActiveTimeBlock(activeTimeBlock - 1)
    }
  }

  const journalTypes: { type: JournalType; label: string; icon: React.ReactNode }[] = [
    { type: "gratitude", label: "Gratitude", icon: <Sparkles className="size-2.5" /> },
    { type: "inspiration", label: "Inspiration", icon: <Lightbulb className="size-2.5" /> },
    { type: "diary", label: "Diary", icon: <PenLine className="size-2.5" /> },
  ]

  return (
    <div className="h-full flex flex-col p-3 overflow-hidden">
      {/* Header - minimal */}
      <header className="mb-2 flex-shrink-0">
        <h1 className="text-base font-semibold text-stone-800 tracking-tight">Daily Career</h1>
      </header>

      {/* Scrollable content */}
      <div className="flex-1 overflow-y-auto space-y-3 pr-1">
        {/* Three Frogs */}
        <section>
          <h2 className="text-[11px] font-medium text-stone-600 mb-1.5">Three Frogs</h2>
          <div className="space-y-1">
            {frogs.map((frog, index) => (
              <div key={frog.id} className="flex items-center gap-1.5">
                <Checkbox
                  checked={frog.completed}
                  onCheckedChange={(checked) => updateFrog(frog.id, { completed: !!checked })}
                  className="size-3.5"
                />
                <span className="text-[10px] text-stone-400 w-3">{index + 1}.</span>
                <Input
                  placeholder="Priority task..."
                  value={frog.text}
                  onChange={(e) => updateFrog(frog.id, { text: e.target.value })}
                  className={`h-6 text-[11px] border-0 border-b border-stone-200 rounded-none bg-transparent focus-visible:ring-0 focus-visible:border-stone-400 px-0 ${
                    frog.completed ? "line-through text-stone-400" : ""
                  }`}
                />
              </div>
            ))}
          </div>
        </section>

        {/* Time Blocks */}
        <section>
          <div className="flex items-center justify-between mb-1.5">
            <h2 className="text-[11px] font-medium text-stone-600">Time Blocks</h2>
            <div className="flex gap-0.5">
              {timeBlockLabels.map((_, index) => (
                <button
                  key={index}
                  onClick={() => setActiveTimeBlock(index)}
                  className={`rounded-full transition-all ${
                    activeTimeBlock === index ? "bg-stone-600 w-3 h-1" : "bg-stone-300 w-1 h-1"
                  }`}
                />
              ))}
            </div>
          </div>

          {/* Swipeable container */}
          <div
            ref={timeBlockRef}
            className="relative overflow-hidden"
            onTouchStart={handleTimeBlockTouchStart}
            onTouchMove={handleTimeBlockTouchMove}
            onTouchEnd={handleTimeBlockTouchEnd}
          >
            <div
              className="flex transition-transform duration-300 ease-out"
              style={{ transform: `translateX(-${activeTimeBlock * 85}%)` }}
            >
              {timeBlockKeys.map((time, index) => (
                <div key={time} className="min-w-[85%] pr-2">
                  <div
                    className={`p-2 rounded-lg border transition-all ${
                      activeTimeBlock === index ? "border-stone-300 bg-stone-50" : "border-stone-200 bg-white opacity-60"
                    }`}
                  >
                    <label className="text-[10px] font-medium text-stone-500 capitalize block mb-1">
                      {timeBlockLabels[index]}
                    </label>
                    <Textarea
                      placeholder={`What did you do?`}
                      value={timeBlocks[time]}
                      onChange={(e) => setTimeBlocks({ ...timeBlocks, [time]: e.target.value })}
                      className="min-h-[40px] text-[11px] border-0 bg-transparent focus-visible:ring-0 resize-none p-0"
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Journal Section */}
        <section className="pb-2">
          <div className="flex items-center justify-between mb-1.5">
            <h2 className="text-[11px] font-medium text-stone-600">Reflection</h2>
            <div className="flex gap-0.5">
              {journalTypes.map(({ type, label, icon }) => (
                <Button
                  key={type}
                  variant={journalType === type ? "default" : "ghost"}
                  size="sm"
                  className={`h-5 text-[9px] px-1.5 gap-0.5 ${
                    journalType === type ? "bg-stone-700 text-white" : "text-stone-500"
                  }`}
                  onClick={() => setJournalType(type)}
                >
                  {icon}
                  {label}
                </Button>
              ))}
            </div>
          </div>
          <Textarea
            placeholder={
              journalType === "gratitude"
                ? "What are you grateful for today?"
                : journalType === "inspiration"
                  ? "What inspired you today?"
                  : "How was your day?"
            }
            value={journalContent}
            onChange={(e) => setJournalContent(e.target.value)}
            className="min-h-[60px] text-[11px] border-stone-200 bg-stone-50/50 resize-none focus-visible:ring-1 focus-visible:ring-stone-300 rounded-lg"
          />
        </section>
      </div>
    </div>
  )
}
