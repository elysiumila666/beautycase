"use client"

import type React from "react"

import { useState, useRef } from "react"
import { CyberloafingPage } from "@/components/cyberloafing-page"
import { DailyCareerPage } from "@/components/daily-career-page"
import { ManifestPage } from "@/components/manifest-page"
import { Grid3X3, MoreHorizontal, Waves, BookOpen, Sparkles, ChevronLeft, ChevronRight, Menu } from "lucide-react"

export default function Home() {
  const [activeTab, setActiveTab] = useState<"loafing" | "record" | "manifest">("loafing")
  const [selectedDate, setSelectedDate] = useState(new Date())
  const [showCalendar, setShowCalendar] = useState(false)

  const weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

  const generateWeekDates = () => {
    const dates = []
    const today = new Date()
    const currentDayOfWeek = today.getDay()

    for (let i = 0; i < 7; i++) {
      const date = new Date(today)
      date.setDate(today.getDate() - currentDayOfWeek + i)
      dates.push(date)
    }
    return dates
  }

  const weekDates = generateWeekDates()

  const getMonthName = (date: Date) => {
    return date.toLocaleDateString("en-US", { month: "long" })
  }

  const isSameDay = (d1: Date, d2: Date) => d1.toDateString() === d2.toDateString()
  const isToday = (date: Date) => date.toDateString() === new Date().toDateString()

  const tabs = [
    { id: "loafing" as const, label: "Loafing", icon: <Waves className="size-5" /> },
    { id: "record" as const, label: "Record", icon: <BookOpen className="size-5" /> },
    { id: "manifest" as const, label: "Manifest", icon: <Sparkles className="size-5" /> },
  ]

  const renderContent = () => {
    switch (activeTab) {
      case "loafing":
        return (
          <div className="h-full bg-white rounded-2xl shadow-[0_2px_10px_rgba(0,0,0,0.08)] overflow-hidden">
            <CyberloafingPage />
          </div>
        )
      case "record":
        return (
          <div className="h-full bg-white rounded-2xl shadow-[0_2px_10px_rgba(0,0,0,0.08)] overflow-hidden">
            <DailyCareerPage />
          </div>
        )
      case "manifest":
        return (
          <div className="h-full bg-white rounded-2xl shadow-[0_2px_10px_rgba(0,0,0,0.08)] overflow-hidden">
            <ManifestPage />
          </div>
        )
    }
  }

  // Compact header for Record tab - just date circle and drawer icon
  const renderRecordHeader = () => (
    <div className="w-full max-w-md mb-2 flex items-center justify-between px-1">
      {/* Date Circle */}
      <button
        onClick={() => setShowCalendar(!showCalendar)}
        className="w-10 h-10 rounded-full bg-stone-100/80 backdrop-blur-sm flex items-center justify-center text-stone-800 font-semibold text-sm hover:bg-stone-200 transition-colors"
      >
        {selectedDate.getDate()}
      </button>

      {/* Drawer Icon - three horizontal lines */}
      <button className="w-10 h-10 rounded-full bg-stone-100/80 backdrop-blur-sm flex items-center justify-center text-stone-600 hover:bg-stone-200 transition-colors">
        <Menu className="size-4" />
      </button>
    </div>
  )

  // Full calendar for Loafing tab
  const renderLoafingHeader = () => (
    <div className="w-full max-w-md mb-2 bg-stone-100/80 backdrop-blur-sm rounded-xl px-3 py-2">
      {/* Top Row: Grid Icon, Month, More Button */}
      <div className="flex items-center justify-between mb-2">
        <button className="p-1.5 rounded-lg bg-white/60 hover:bg-white transition-colors">
          <Grid3X3 className="size-4 text-stone-600" />
        </button>
        <span className="text-sm font-medium text-stone-800">{getMonthName(selectedDate)}</span>
        <button className="p-1.5 rounded-lg bg-white/60 hover:bg-white transition-colors">
          <MoreHorizontal className="size-4 text-stone-600" />
        </button>
      </div>

      {/* Week Days Row */}
      <div className="grid grid-cols-7 gap-1 mb-0.5">
        {weekDays.map((day, index) => (
          <div
            key={day}
            className={`text-center text-[10px] font-medium ${
              index === 0 || index === 6 ? "text-stone-400" : "text-stone-500"
            }`}
          >
            {day}
          </div>
        ))}
      </div>

      {/* Dates Row */}
      <div className="grid grid-cols-7 gap-1">
        {weekDates.map((date, index) => {
          const selected = isSameDay(date, selectedDate)
          const today = isToday(date)
          const isWeekend = index === 0 || index === 6

          return (
            <button
              key={index}
              onClick={() => setSelectedDate(date)}
              className={`relative py-1 text-center text-sm font-medium rounded-lg transition-all ${
                selected
                  ? "bg-stone-800 text-white"
                  : today
                  ? "ring-2 ring-white/80 ring-inset text-stone-800 bg-white/40"
                  : isWeekend
                  ? "text-stone-400 hover:bg-white/60"
                  : "text-stone-600 hover:bg-white/60"
              }`}
            >
              {date.getDate()}
            </button>
          )
        })}
      </div>
    </div>
  )

  // Calendar popup for Record tab
  const renderCalendarPopup = () =>
    showCalendar &&
    activeTab === "record" && (
      <div className="absolute top-14 left-3 z-50 bg-white rounded-xl shadow-lg p-3 w-64">
        <div className="flex items-center justify-between mb-2">
          <button className="p-1 text-stone-400 hover:text-stone-600">
            <ChevronLeft className="size-4" />
          </button>
          <span className="text-sm font-medium text-stone-800">{getMonthName(selectedDate)}</span>
          <button className="p-1 text-stone-400 hover:text-stone-600">
            <ChevronRight className="size-4" />
          </button>
        </div>
        <div className="grid grid-cols-7 gap-1 mb-1">
          {weekDays.map((day, index) => (
            <div
              key={day}
              className={`text-center text-[10px] font-medium ${
                index === 0 || index === 6 ? "text-stone-400" : "text-stone-500"
              }`}
            >
              {day}
            </div>
          ))}
        </div>
        <div className="grid grid-cols-7 gap-1">
          {weekDates.map((date, index) => {
            const selected = isSameDay(date, selectedDate)
            const today = isToday(date)
            const isWeekend = index === 0 || index === 6

            return (
              <button
                key={index}
                onClick={() => {
                  setSelectedDate(date)
                  setShowCalendar(false)
                }}
                className={`py-1 text-center text-xs font-medium rounded-md transition-all ${
                  selected
                    ? "bg-stone-800 text-white"
                    : today
                    ? "ring-1 ring-stone-300 text-stone-800"
                    : isWeekend
                    ? "text-stone-400 hover:bg-stone-100"
                    : "text-stone-600 hover:bg-stone-100"
                }`}
              >
                {date.getDate()}
              </button>
            )
          })}
        </div>
      </div>
    )

  return (
    <main className="h-[100dvh] bg-stone-200 flex flex-col items-center px-3 pt-3 pb-0 relative">
      {/* Conditional Header based on active tab */}
      {activeTab === "loafing" && renderLoafingHeader()}
      {activeTab === "record" && renderRecordHeader()}
      {/* No header for manifest tab */}

      {/* Calendar popup */}
      {renderCalendarPopup()}
      {showCalendar && <div className="fixed inset-0 z-40" onClick={() => setShowCalendar(false)} />}

      {/* Main Content Area */}
      <div className="flex-1 w-full max-w-md min-h-0 mb-2">{renderContent()}</div>

      {/* Bottom Tab Bar - cleaner look without border */}
      <div className="w-full max-w-md bg-stone-100/90 backdrop-blur-sm rounded-t-2xl px-6 py-2 pb-[max(env(safe-area-inset-bottom),8px)]">
        <div className="flex items-center justify-around">
          {tabs.map((tab) => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              className={`flex flex-col items-center gap-0.5 py-1 px-4 transition-all ${
                activeTab === tab.id ? "text-stone-800" : "text-stone-400"
              }`}
            >
              <div
                className={`p-1.5 rounded-xl transition-all ${activeTab === tab.id ? "bg-white shadow-sm" : ""}`}
              >
                {tab.icon}
              </div>
              <span className="text-[10px] font-medium">{tab.label}</span>
            </button>
          ))}
        </div>
      </div>
    </main>
  )
}
